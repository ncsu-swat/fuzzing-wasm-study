import lldb

target_output=""
path_filter=""
trace_output_file=""

def write_callback(frame, bp_loc, _dict):
  global target_output, path_filter, trace_output_file

  print("+ write() breakpoint hit")
  if len(target_output) == 0 and len(path_filter) == 0 and len(trace_output_file) == 0:
    print("- target_output, path_filter, and trace_output_file variables are not set")

  process = frame.GetThread().GetProcess()
  regs = frame.GetRegisters()
  reg_map = {}

  for reg_set in regs:
      if "general purpose" in reg_set.GetName().lower():
          for reg in reg_set:
              reg_map[reg.GetName()] = reg.GetValue()

  def get_reg(*names):
      for name in names:
          if name in reg_map:
              return int(reg_map[name], 0)
      raise Exception("- Register not found")

  try:
      fd = get_reg("rdi", "x0")
      buf = get_reg("rsi", "x1")
      count = get_reg("rdx", "x2")
  except Exception as e:
      print(f"- Register error: {e}")
      return False

  if fd not in (1, 2):  # stdout or stderr
      return False

  error = lldb.SBError()
  mem = process.ReadMemory(buf, count, error)
  if not error.Success() or mem is None:
      print(f"- Memory read failed: {error.GetCString()}")
      return False

  output = mem.decode('utf-8', errors='ignore').strip()

  sign = '+' # default behavior is to check if buggy output was reproduced [in some cases, it might be difficult to check if buggy output was reproduced. so, we can check if the expected output was not produced.]
  if target_output[0] in ['+', '-']:
    sign = target_output[0]
    target_output = target_output[1:]

  match = (
    (sign == '+' and target_output in output) or
    (sign == '-' and target_output not in output)
  )

  if match:
    with open(trace_output_file, 'a') as trace_out_file:
      # print(f"+ write(fd={fd}): {output}")
      # print(f"+ Backtrace:")
      frame_counter = 0
      for f in frame.GetThread():
        le = f.GetLineEntry()
        fs = le.GetFileSpec()

        if fs and fs.GetDirectory() and path_filter in fs.GetDirectory():
          # print(f"{fs.GetDirectory()}/{fs.GetFilename()}:{le.GetLine()}")
          trace_out_file.write(f"{fs.GetDirectory()}/{fs.GetFilename()}:{le.GetLine()}\n")
          frame_counter += 1
        
        # Save at most 5 most recent frames
        if frame_counter == 5:
          break

    return True # stop debugging

  return False  # continue execution

def monitor_segfaults(debugger):
  # global path_filter, trace_output_file

  # debugger.SetAsync(True)
  # target = debugger.GetSelectedTarget()
  # process = target.GetProcess()

  # # Attach listener before continuing
  # listener = lldb.SBListener("crash-listener")
  # process.GetBroadcaster().AddListener(listener, lldb.SBProcess.eBroadcastBitStateChanged)

  # # Now continue the process after adding the listener
  # process.Continue()

  # event = lldb.SBEvent()
  # while listener.WaitForEvent(3, event):
  #   if lldb.SBProcess.EventIsProcessEvent(event):
  #     state = lldb.SBProcess.GetStateFromEvent(event)
  #     if state == lldb.eStateStopped:
  #       thread = process.GetSelectedThread()
  #       print(f"\nGot thread: {thread}\n")
  #       if thread.GetStopReason() == lldb.eStopReasonSignal:
  #         signal = thread.GetStopReasonDataAtIndex(0)
  #         print(f"\nGot signal: {signal}\n")
  #         if signal == 11 or signal == 6:  # SIGSEGV (11), SIGABRT (6)
  #           with open(trace_output_file, 'a') as f:
  #             frame_counter = 0
  #             for fidx in thread:
  #               print(f"\nGot frame idx: {fidx}")
  #               le = fidx.GetLineEntry()
  #               fs = le.GetFileSpec()
  #               if fs and fs.GetDirectory() and path_filter in fs.GetDirectory():
  #                   f.write(f"{fs.GetDirectory()}/{fs.GetFilename()}:{le.GetLine()}\n")
  #                   frame_counter += 1

  #               # Save at most 5 most recent frames
  #               if frame_counter == 5:
  #                 break
  #           return True
  # return False
  return

def crash_hook(debugger, command, result, internal_dict):
  target = debugger.GetSelectedTarget()
  process = target.GetProcess()

  for thread in process:
    if thread.GetStopReason() == lldb.eStopReasonSignal:
      signal_number = thread.GetStopReasonDataAtIndex(0)
      if signal_number == 11 or signal_number == 6:  # SIGSEGV or SIGABRT
        result.PutCString("\n!!! SIGSEGV or SIGABRT detected !!!\n")

        with open(trace_output_file, 'a') as f:
          frame_counter = 0
          for fidx in thread:
            le = fidx.GetLineEntry()
            fs = le.GetFileSpec()
            if fs and fs.GetDirectory() and path_filter in fs.GetDirectory():
                f.write(f"{fs.GetDirectory()}/{fs.GetFilename()}:{le.GetLine()}\n")
                frame_counter += 1

            # Save at most 5 most recent frames
            if frame_counter == 5:
              break

        result.SetStatus(lldb.eReturnStatusSuccessFinishResult)

  debugger.HandleCommand("continue")