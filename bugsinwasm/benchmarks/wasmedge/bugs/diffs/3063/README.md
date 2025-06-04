Original error is: "out of bounds". But, WasmEdge treats runtime exceptions as crashes. So, the output message becomes "Aborted" when run through lldb.
