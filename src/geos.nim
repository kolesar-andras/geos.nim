# Generated @ 2022-11-23T14:47:45+01:00
# Command line:
#   /home/kolesar/.nimble/pkgs/nimterop-0.6.13/nimterop/toast --pnim --dynlib libgeos_c.so lib/geos_c.h

# tree-sitter parse error: 'using std::size_t;', skipped
# const 'GEOS_CAPI_FIRST_INTERFACE' has unsupported value 'GEOS_CAPI_VERSION_MAJOR'
{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}


{.pragma: impgeos_cHdr, header: "/home/kolesar/Dokumentumok/fejlesztések/.sandbox/nim/geos/lib/geos_c.h".}
{.pragma: impgeos_cDyn, dynlib: "libgeos_c.so".}
{.experimental: "codeReordering".}
defineEnum(GEOSGeomTypes)
defineEnum(GEOSByteOrders)   ## ```
                             ##   Byte orders exposed via the C API
                             ## ```
defineEnum(GEOSBufCapStyles)
defineEnum(GEOSBufJoinStyles)
defineEnum(GEOSRelateBoundaryNodeRules) ## ```
                                        ##   *********************************************************************
                                        ##   
                                        ##     Dimensionally Extended 9 Intersection Model related
                                        ##   
                                        ##   ********************************************************************
                                        ##      These are for use with GEOSRelateBoundaryNodeRule (flags param)
                                        ## ```
defineEnum(GEOSValidFlags) ## ```
                           ##   *********************************************************************
                           ##   
                           ##     Validity checking
                           ##   
                           ##   ********************************************************************
                           ##      These are for use with GEOSisValidDetail (flags param)
                           ## ```
const
  GEOS_VERSION_MAJOR* = 3
  GEOS_VERSION_MINOR* = 9
  GEOS_VERSION_PATCH* = 0
  GEOS_VERSION_FULL* = "3.9.0"
  GEOS_JTS_PORT* = "1.17.0"
  GEOS_CAPI_VERSION_MAJOR* = 1
  GEOS_CAPI_VERSION_MINOR* = 16
  GEOS_CAPI_VERSION_PATCH* = 2
  GEOS_CAPI_VERSION* = "3.9.0-CAPI-1.16.2"
  GEOS_CAPI_LAST_INTERFACE* = (GEOS_CAPI_VERSION_MAJOR +
      typeof(GEOS_CAPI_VERSION_MAJOR)(GEOS_CAPI_VERSION_MINOR))
  GEOS_POINT* = (0).GEOSGeomTypes
  GEOS_LINESTRING* = (GEOS_POINT + 1).GEOSGeomTypes
  GEOS_LINEARRING* = (GEOS_LINESTRING + 1).GEOSGeomTypes
  GEOS_POLYGON* = (GEOS_LINEARRING + 1).GEOSGeomTypes
  GEOS_MULTIPOINT* = (GEOS_POLYGON + 1).GEOSGeomTypes
  GEOS_MULTILINESTRING* = (GEOS_MULTIPOINT + 1).GEOSGeomTypes
  GEOS_MULTIPOLYGON* = (GEOS_MULTILINESTRING + 1).GEOSGeomTypes
  GEOS_GEOMETRYCOLLECTION* = (GEOS_MULTIPOLYGON + 1).GEOSGeomTypes
  GEOS_WKB_XDR* = (0).GEOSByteOrders ## ```
                                     ##   Big Endian
                                     ## ```
  GEOS_WKB_NDR* = (1).GEOSByteOrders ## ```
                                     ##   Little Endian
                                     ## ```
  GEOSBUF_CAP_ROUND* = (1).GEOSBufCapStyles
  GEOSBUF_CAP_FLAT* = (2).GEOSBufCapStyles
  GEOSBUF_CAP_SQUARE* = (3).GEOSBufCapStyles
  GEOSBUF_JOIN_ROUND* = (1).GEOSBufJoinStyles
  GEOSBUF_JOIN_MITRE* = (2).GEOSBufJoinStyles
  GEOSBUF_JOIN_BEVEL* = (3).GEOSBufJoinStyles
  GEOSRELATE_BNR_MOD2* = (1).GEOSRelateBoundaryNodeRules ## ```
                                                         ##   MOD2 and OGC are the same rule, and is the default
                                                         ##   	 used by GEOSRelatePattern
                                                         ## ```
  GEOSRELATE_BNR_OGC* = (1).GEOSRelateBoundaryNodeRules
  GEOSRELATE_BNR_ENDPOINT* = (2).GEOSRelateBoundaryNodeRules
  GEOSRELATE_BNR_MULTIVALENT_ENDPOINT* = (3).GEOSRelateBoundaryNodeRules
  GEOSRELATE_BNR_MONOVALENT_ENDPOINT* = (4).GEOSRelateBoundaryNodeRules
  GEOSVALID_ALLOW_SELFTOUCHING_RING_FORMING_HOLE* = (1).GEOSValidFlags
  GEOS_PREC_NO_TOPO* = (1 shl typeof(1)(0))
  GEOS_PREC_KEEP_COLLAPSED* = (1 shl typeof(1)(1))
type
  GEOSContextHandle_t* {.importc, impgeos_cHdr.} = ptr pointer
  GEOSMessageHandler* {.importc, impgeos_cHdr.} = proc (fmt: cstring) {.cdecl,
      varargs.}
  GEOSMessageHandler_r* {.importc, impgeos_cHdr.} = proc (message: cstring;
      userdata: pointer) {.cdecl.}
  GEOSGeometry* {.importc, impgeos_cHdr.} = pointer
  GEOSPreparedGeometry* {.importc, impgeos_cHdr.} = pointer
  GEOSCoordSequence* {.importc, impgeos_cHdr.} = pointer
  GEOSSTRtree* {.importc, impgeos_cHdr.} = pointer
  GEOSBufferParams* {.importc, impgeos_cHdr.} = pointer
  GEOSGeom* {.importc, impgeos_cHdr.} = ptr GEOSGeometry ## ```
                                                         ##   Those are compatibility definitions for source compatibility
                                                         ##    with GEOS 2.X clients relying on that type.
                                                         ## ```
  GEOSCoordSeq* {.importc, impgeos_cHdr.} = ptr GEOSCoordSequence
  GEOSQueryCallback* {.importc, impgeos_cHdr.} = proc (item: pointer;
      userdata: pointer) {.cdecl.}
  GEOSDistanceCallback* {.importc, impgeos_cHdr.} = proc (item1: pointer;
      item2: pointer; distance: ptr cdouble; userdata: pointer): cint {.cdecl.}
  GEOSInterruptCallback* {.importc, impgeos_cHdr.} = proc () {.cdecl.}
  GEOSWKTReader* {.importc, impgeos_cHdr.} = pointer
  GEOSWKTWriter* {.importc, impgeos_cHdr.} = pointer
  GEOSWKBReader* {.importc, impgeos_cHdr.} = pointer
  GEOSWKBWriter* {.importc, impgeos_cHdr.} = pointer
proc GEOS_interruptRegisterCallback*(cb: ptr GEOSInterruptCallback): ptr GEOSInterruptCallback {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Request safe interruption of operations
                                  ## ```
proc GEOS_interruptRequest*() {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                              ##   Request safe interruption of operations
                                                              ## ```
proc GEOS_interruptCancel*() {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                             ##   Cancel a pending interruption request
                                                             ## ```
proc initGEOS_r*(notice_function: GEOSMessageHandler;
                 error_function: GEOSMessageHandler): GEOSContextHandle_t {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @deprecated in 3.5.0
                                  ##        initialize using GEOS_init_r() and set the message handlers using
                                  ##        GEOSContext_setNoticeHandler_r and/or GEOSContext_setErrorHandler_r
                                  ## ```
proc finishGEOS_r*(handle: GEOSContextHandle_t) {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   @deprecated in 3.5.0 replaced by GEOS_finish_r.
                                                                                ## ```
proc GEOS_init_r*(): GEOSContextHandle_t {.importc, cdecl, impgeos_cDyn.}
proc GEOS_finish_r*(handle: GEOSContextHandle_t) {.importc, cdecl, impgeos_cDyn.}
proc GEOSContext_setNoticeHandler_r*(extHandle: GEOSContextHandle_t;
                                     nf: GEOSMessageHandler): GEOSMessageHandler {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSContext_setErrorHandler_r*(extHandle: GEOSContextHandle_t;
                                    ef: GEOSMessageHandler): GEOSMessageHandler {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSContext_setNoticeMessageHandler_r*(extHandle: GEOSContextHandle_t;
    nf: GEOSMessageHandler_r; userData: pointer): GEOSMessageHandler_r {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Sets a notice message handler on the given GEOS context.
                                  ##   
                                  ##    @param extHandle the GEOS context
                                  ##    @param nf the message handler
                                  ##    @param userData optional user data pointer that will be passed to the message handler
                                  ##   
                                  ##    @return the previously configured message handler or NULL if no message handler was configured
                                  ## ```
proc GEOSContext_setErrorMessageHandler_r*(extHandle: GEOSContextHandle_t;
    ef: GEOSMessageHandler_r; userData: pointer): GEOSMessageHandler_r {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Sets an error message handler on the given GEOS context.
                                  ##   
                                  ##    @param extHandle the GEOS context
                                  ##    @param ef the message handler
                                  ##    @param userData optional user data pointer that will be passed to the message handler
                                  ##   
                                  ##    @return the previously configured message handler or NULL if no message handler was configured
                                  ## ```
proc GEOSversion*(): cstring {.importc, cdecl, impgeos_cDyn.}
proc GEOSGeomFromWKT_r*(handle: GEOSContextHandle_t; wkt: cstring): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomToWKT_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cstring {.
    importc, cdecl, impgeos_cDyn.}
proc GEOS_getWKBOutputDims_r*(handle: GEOSContextHandle_t): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOS_setWKBOutputDims_r*(handle: GEOSContextHandle_t; newDims: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOS_getWKBByteOrder_r*(handle: GEOSContextHandle_t): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOS_setWKBByteOrder_r*(handle: GEOSContextHandle_t; byteOrder: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomFromWKB_buf_r*(handle: GEOSContextHandle_t; wkb: ptr cuchar;
                            size: uint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomToWKB_buf_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                          size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomFromHEX_buf_r*(handle: GEOSContextHandle_t; hex: ptr cuchar;
                            size: uint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomToHEX_buf_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                          size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_create_r*(handle: GEOSContextHandle_t; size: cuint;
                            dims: cuint): ptr GEOSCoordSequence {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   *********************************************************************
                         ##   
                         ##    Coordinate Sequence functions
                         ##   
                         ##   ********************************************************************
                         ##     
                         ##    Create a Coordinate sequence with size'' coordinates
                         ##    of dims'' dimensions.
                         ##    Return NULL on exception.
                         ## ```
proc GEOSCoordSeq_clone_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Clone a Coordinate Sequence.
                                  ##    Return NULL on exception.
                                  ## ```
proc GEOSCoordSeq_destroy_r*(handle: GEOSContextHandle_t;
                             s: ptr GEOSCoordSequence) {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Destroy a Coordinate Sequence.
                  ## ```
proc GEOSCoordSeq_setX_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Set ordinate values in a Coordinate Sequence.
                  ##    Return 0 on exception.
                  ## ```
proc GEOSCoordSeq_setY_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_setZ_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_setXY_r*(handle: GEOSContextHandle_t;
                           s: ptr GEOSCoordSequence; idx: cuint; x: cdouble;
                           y: cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_setXYZ_r*(handle: GEOSContextHandle_t;
                            s: ptr GEOSCoordSequence; idx: cuint; x: cdouble;
                            y: cdouble; z: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_setOrdinate_r*(handle: GEOSContextHandle_t;
                                 s: ptr GEOSCoordSequence; idx: cuint;
                                 dim: cuint; val: cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getX_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Get ordinate values from a Coordinate Sequence.
                  ##    Return 0 on exception.
                  ## ```
proc GEOSCoordSeq_getY_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_getZ_r*(handle: GEOSContextHandle_t; s: ptr GEOSCoordSequence;
                          idx: cuint; val: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_getXY_r*(handle: GEOSContextHandle_t;
                           s: ptr GEOSCoordSequence; idx: cuint; x: ptr cdouble;
                           y: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getXYZ_r*(handle: GEOSContextHandle_t;
                            s: ptr GEOSCoordSequence; idx: cuint;
                            x: ptr cdouble; y: ptr cdouble; z: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getOrdinate_r*(handle: GEOSContextHandle_t;
                                 s: ptr GEOSCoordSequence; idx: cuint;
                                 dim: cuint; val: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getSize_r*(handle: GEOSContextHandle_t;
                             s: ptr GEOSCoordSequence; size: ptr cuint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Get size and dimensions info from a Coordinate Sequence.
                                  ##    Return 0 on exception.
                                  ## ```
proc GEOSCoordSeq_getDimensions_r*(handle: GEOSContextHandle_t;
                                   s: ptr GEOSCoordSequence; dims: ptr cuint): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_isCCW_r*(handle: GEOSContextHandle_t;
                           s: ptr GEOSCoordSequence; is_ccw: cstring): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Check orientation of a CoordinateSequence and set 'is_ccw' to 1
                                  ##    if it has counter-clockwise orientation, 0 otherwise.
                                  ##    Return 0 on exception, 1 on success.
                                  ## ```
proc GEOSProject_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                    p: ptr GEOSGeometry): cdouble {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                  ##   *********************************************************************
                                                                                  ##   
                                                                                  ##     Linear referencing functions -- there are more, but these are
                                                                                  ##     probably sufficient for most purposes
                                                                                  ##   
                                                                                  ##   ********************************************************************
                                                                                  ##     
                                                                                  ##    GEOSGeometry ownership is retained by caller
                                                                                  ##    
                                                                                  ##      Return distance of point 'p' projected on 'g' from origin
                                                                                  ##    of 'g'. Geometry 'g' must be a lineal geometry.
                                                                                  ##    Return -1 on exception
                                                                                  ## ```
proc GEOSInterpolate_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                        d: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return closest point to given distance within geometry
                  ##    Geometry must be a LineString
                  ## ```
proc GEOSProjectNormalized_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                              p: ptr GEOSGeometry): cdouble {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSInterpolateNormalized_r*(handle: GEOSContextHandle_t;
                                  g: ptr GEOSGeometry; d: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSBuffer_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                   width: cdouble; quadsegs: cint): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   *********************************************************************
                         ##   
                         ##    Buffer related functions
                         ##   
                         ##   ********************************************************************
                         ##      @return NULL on exception
                         ## ```
proc GEOSBufferParams_create_r*(handle: GEOSContextHandle_t): ptr GEOSBufferParams {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return 0 on exception
                                  ## ```
proc GEOSBufferParams_destroy_r*(handle: GEOSContextHandle_t;
                                 parms: ptr GEOSBufferParams) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSBufferParams_setEndCapStyle_r*(handle: GEOSContextHandle_t;
                                        p: ptr GEOSBufferParams; style: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return 0 on exception
                                  ## ```
proc GEOSBufferParams_setJoinStyle_r*(handle: GEOSContextHandle_t;
                                      p: ptr GEOSBufferParams; joinStyle: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return 0 on exception
                                  ## ```
proc GEOSBufferParams_setMitreLimit_r*(handle: GEOSContextHandle_t;
                                       p: ptr GEOSBufferParams;
                                       mitreLimit: cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   @return 0 on exception
                         ## ```
proc GEOSBufferParams_setQuadrantSegments_r*(handle: GEOSContextHandle_t;
    p: ptr GEOSBufferParams; quadSegs: cint): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   @return 0 on exception
                  ## ```
proc GEOSBufferParams_setSingleSided_r*(handle: GEOSContextHandle_t;
                                        p: ptr GEOSBufferParams;
                                        singleSided: cint): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   @param singleSided: 1 for single sided, 0 otherwise 
                         ##      @return 0 on exception
                         ## ```
proc GEOSBufferWithParams_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                             p: ptr GEOSBufferParams; width: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return NULL on exception
                                  ## ```
proc GEOSBufferWithStyle_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                            width: cdouble; quadsegs: cint; endCapStyle: cint;
                            joinStyle: cint; mitreLimit: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   These functions return NULL on exception.
                                  ## ```
proc GEOSSingleSidedBuffer_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                              width: cdouble; quadsegs: cint; joinStyle: cint;
                              mitreLimit: cdouble; leftSide: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   These functions return NULL on exception. Only LINESTRINGs are accepted. 
                                  ##      @deprecated in 3.3.0: use GEOSOffsetCurve instead
                                  ## ```
proc GEOSOffsetCurve_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                        width: cdouble; quadsegs: cint; joinStyle: cint;
                        mitreLimit: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Only LINESTRINGs are accepted.
                  ##    @param width : offset distance.
                  ##                   negative for right side offset.
                  ##                   positive for left side offset.
                  ##    @return NULL on exception
                  ## ```
proc GEOSGeom_createPoint_r*(handle: GEOSContextHandle_t;
                             s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createPointFromXY_r*(handle: GEOSContextHandle_t; x: cdouble;
                                   y: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyPoint_r*(handle: GEOSContextHandle_t): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createLinearRing_r*(handle: GEOSContextHandle_t;
                                  s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createLineString_r*(handle: GEOSContextHandle_t;
                                  s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyLineString_r*(handle: GEOSContextHandle_t): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyPolygon_r*(handle: GEOSContextHandle_t): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Second argument is an array of GEOSGeometry* objects.
                                  ##    The caller remains owner of the array, but pointed-to
                                  ##    objects become ownership of the returned GEOSGeometry.
                                  ## ```
proc GEOSGeom_createPolygon_r*(handle: GEOSContextHandle_t;
                               shell: ptr GEOSGeometry;
                               holes: ptr ptr GEOSGeometry; nholes: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createCollection_r*(handle: GEOSContextHandle_t; `type`: cint;
                                  geoms: ptr ptr GEOSGeometry; ngeoms: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyCollection_r*(handle: GEOSContextHandle_t; `type`: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_clone_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_destroy_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSEnvelope_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSIntersection_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                         g2: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSIntersectionPrec_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                             g2: ptr GEOSGeometry; gridSize: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSConvexHull_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSMinimumRotatedRectangle_r*(handle: GEOSContextHandle_t;
                                    g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Returns the minimum rotated rectangular POLYGON which encloses the input geometry. The rectangle
                                  ##    has width equal to the minimum diameter, and a longer length. If the convex hill of the input is
                                  ##    degenerate (a line or point) a LINESTRING or POINT is returned. The minimum rotated rectangle can
                                  ##    be used as an extremely generalized representation for the given geometry.
                                  ## ```
proc GEOSMaximumInscribedCircle_r*(handle: GEOSContextHandle_t;
                                   g: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSLargestEmptyCircle_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                               boundary: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSMinimumWidth_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Returns a LINESTRING geometry which represents the minimum diameter of the geometry.
                                  ##    The minimum diameter is defined to be the width of the smallest band that
                                  ##    contains the geometry, where a band is a strip of the plane defined
                                  ##    by two parallel lines. This can be thought of as the smallest hole that the geometry
                                  ##    can be moved through, with a single rotation.
                                  ## ```
proc GEOSMinimumClearanceLine_r*(handle: GEOSContextHandle_t;
                                 g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSMinimumClearance_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                             distance: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSDifference_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                       g2: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSDifferencePrec_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                           g2: ptr GEOSGeometry; gridSize: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSymDifference_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                          g2: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSSymDifferencePrec_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                              g2: ptr GEOSGeometry; gridSize: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSBoundary_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSUnion_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                  g2: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSUnionPrec_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                      g2: ptr GEOSGeometry; gridSize: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSUnaryUnion_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSUnaryUnionPrec_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                           gridSize: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCoverageUnion_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   GEOSCoverageUnion is an optimized union algorithm for polygonal inputs that are correctly
                                  ##    noded and do not overlap. It will not generate an error (return NULL) for inputs that
                                  ##    do not satisfy this constraint.
                                  ## ```
proc GEOSUnionCascaded_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @deprecated in 3.3.0: use GEOSUnaryUnion_r instead
                                  ## ```
proc GEOSPointOnSurface_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGetCentroid_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSMinimumBoundingCircle_r*(handle: GEOSContextHandle_t;
                                  g: ptr GEOSGeometry; radius: ptr cdouble;
                                  center: ptr ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSNode_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSClipByRect_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                       xmin: cdouble; ymin: cdouble; xmax: cdouble;
                       ymax: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Fast, non-robust intersection between an arbitrary geometry and
                  ##    a rectangle. The returned geometry may be invalid.
                  ## ```
proc GEOSPolygonize_r*(handle: GEOSContextHandle_t; geoms: GEOSGeometry;
                       ngeoms: cuint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPolygonize_valid_r*(handle: GEOSContextHandle_t; geoms: GEOSGeometry;
                             ngems: cuint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPolygonizer_getCutEdges_r*(handle: GEOSContextHandle_t;
                                    geoms: GEOSGeometry; ngeoms: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPolygonize_full_r*(handle: GEOSContextHandle_t;
                            input: ptr GEOSGeometry; cuts: ptr ptr GEOSGeometry;
                            dangles: ptr ptr GEOSGeometry;
                            invalidRings: ptr ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSBuildArea_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSLineMerge_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSReverse_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSimplify_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                     tolerance: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSTopologyPreserveSimplify_r*(handle: GEOSContextHandle_t;
                                     g: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_extractUniquePoints_r*(handle: GEOSContextHandle_t;
                                     g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return all distinct vertices of input geometry as a MULTIPOINT.
                                  ##    Note that only 2 dimensions of the vertices are considered when
                                  ##    testing for equality.
                                  ## ```
proc GEOSSharedPaths_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                        g2: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Find paths shared between the two given lineal geometries.
                         ##   
                         ##    Returns a GEOMETRYCOLLECTION having two elements:
                         ##    - first element is a MULTILINESTRING containing shared paths
                         ##      having the _same_ direction on both inputs
                         ##    - second element is a MULTILINESTRING containing shared paths
                         ##      having the _opposite_ direction on the two inputs
                         ##   
                         ##    Returns NULL on exception
                         ## ```
proc GEOSSnap_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                 g2: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Snap first geometry on to second with given tolerance
                                  ##    Returns a newly allocated geometry, or NULL on exception
                                  ## ```
proc GEOSDelaunayTriangulation_r*(handle: GEOSContextHandle_t;
                                  g: ptr GEOSGeometry; tolerance: cdouble;
                                  onlyEdges: cint): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return a Delaunay triangulation of the vertex of the given geometry
                         ##   
                         ##    @param g the input geometry whose vertex will be used as "sites"
                         ##    @param tolerance optional snapping tolerance to use for improved robustness
                         ##    @param onlyEdges if non-zero will return a MULTILINESTRING, otherwise it will
                         ##                     return a GEOMETRYCOLLECTION containing triangular POLYGONs.
                         ##   
                         ##    @return  a newly allocated geometry, or NULL on exception
                         ## ```
proc GEOSVoronoiDiagram_r*(extHandle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                           env: ptr GEOSGeometry; tolerance: cdouble;
                           onlyEdges: cint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Returns the Voronoi polygons of a set of Vertices given as input
                  ##   
                  ##    @param g the input geometry whose vertex will be used as sites.
                  ##    @param tolerance snapping tolerance to use for improved robustness
                  ##    @param onlyEdges whether to return only edges of the Voronoi cells
                  ##    @param env clipping envelope for the returned diagram, automatically
                  ##               determined if NULL.
                  ##               The diagram will be clipped to the larger
                  ##               of this envelope or an envelope surrounding the sites.
                  ##   
                  ##    @return a newly allocated geometry, or NULL on exception.
                  ## ```
proc GEOSSegmentIntersection_r*(extHandle: GEOSContextHandle_t; ax0: cdouble;
                                ay0: cdouble; ax1: cdouble; ay1: cdouble;
                                bx0: cdouble; by0: cdouble; bx1: cdouble;
                                by1: cdouble; cx: ptr cdouble; cy: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSDisjoint_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                     g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSTouches_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                    g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSIntersects_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                       g2: ptr GEOSGeometry): cchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCrosses_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                    g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSWithin_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                   g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSContains_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                     g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSOverlaps_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                     g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSEquals_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                   g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSEqualsExact_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                        g2: ptr GEOSGeometry; tolerance: cdouble): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCovers_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                   g2: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSCoveredBy_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                      g2: ptr GEOSGeometry): cchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPrepare_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSPreparedGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   *********************************************************************
                                  ##   
                                  ##     Prepared Geometry Binary predicates - return 2 on exception, 1 on true, 0 on false
                                  ##   
                                  ##   ********************************************************************
                                  ##     
                                  ##    GEOSGeometry ownership is retained by caller
                                  ## ```
proc GEOSPreparedGeom_destroy_r*(handle: GEOSContextHandle_t;
                                 g: ptr GEOSPreparedGeometry) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPreparedContains_r*(handle: GEOSContextHandle_t;
                             pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedContainsProperly_r*(handle: GEOSContextHandle_t;
                                     pg1: ptr GEOSPreparedGeometry;
                                     g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSPreparedCoveredBy_r*(handle: GEOSContextHandle_t;
                              pg1: ptr GEOSPreparedGeometry;
                              g2: ptr GEOSGeometry): cchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPreparedCovers_r*(handle: GEOSContextHandle_t;
                           pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedCrosses_r*(handle: GEOSContextHandle_t;
                            pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedDisjoint_r*(handle: GEOSContextHandle_t;
                             pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedIntersects_r*(handle: GEOSContextHandle_t;
                               pg1: ptr GEOSPreparedGeometry;
                               g2: ptr GEOSGeometry): cchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPreparedOverlaps_r*(handle: GEOSContextHandle_t;
                             pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedTouches_r*(handle: GEOSContextHandle_t;
                            pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedWithin_r*(handle: GEOSContextHandle_t;
                           pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedNearestPoints_r*(handle: GEOSContextHandle_t;
                                  pg1: ptr GEOSPreparedGeometry;
                                  g2: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return 0 on exception, the closest points of the two geometries otherwise.
                                  ##    The first point comes from pg1 geometry and the second point comes from g2.
                                  ## ```
proc GEOSPreparedDistance_r*(handle: GEOSContextHandle_t;
                             pg1: ptr GEOSPreparedGeometry;
                             g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSTRtree_create_r*(handle: GEOSContextHandle_t; nodeCapacity: uint): ptr GEOSSTRtree {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSTRtree_insert_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree;
                           g: ptr GEOSGeometry; item: pointer) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSSTRtree_query_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree;
                          g: ptr GEOSGeometry; callback: GEOSQueryCallback;
                          userdata: pointer) {.importc, cdecl, impgeos_cDyn.}
proc GEOSSTRtree_nearest_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree;
                            geom: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSSTRtree_nearest_generic_r*(handle: GEOSContextHandle_t;
                                    tree: ptr GEOSSTRtree; item: pointer;
                                    itemEnvelope: ptr GEOSGeometry;
                                    distancefn: GEOSDistanceCallback;
                                    userdata: pointer): pointer {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSSTRtree_iterate_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree;
                            callback: GEOSQueryCallback; userdata: pointer) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSTRtree_remove_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree;
                           g: ptr GEOSGeometry; item: pointer): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSSTRtree_destroy_r*(handle: GEOSContextHandle_t; tree: ptr GEOSSTRtree) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSisEmpty_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSisSimple_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSisRing_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSHasZ_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSisClosed_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSRelatePattern_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                          g2: ptr GEOSGeometry; pat: cstring): cchar {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   return 2 on exception, 1 on true, 0 on false
                         ## ```
proc GEOSRelate_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                   g2: ptr GEOSGeometry): cstring {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                  ##   return NULL on exception, a string to GEOSFree otherwise
                                                                                  ## ```
proc GEOSRelatePatternMatch_r*(handle: GEOSContextHandle_t; mat: cstring;
                               pat: cstring): cchar {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   return 2 on exception, 1 on true, 0 on false
                  ## ```
proc GEOSRelateBoundaryNodeRule_r*(handle: GEOSContextHandle_t;
                                   g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                   bnr: cint): cstring {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   return NULL on exception, a string to GEOSFree otherwise
                  ## ```
proc GEOSisValid_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   return 2 on exception, 1 on true, 0 on false
                                  ## ```
proc GEOSisValidReason_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cstring {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   return NULL on exception, a string to GEOSFree otherwise
                                  ## ```
proc GEOSisValidDetail_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                          flags: cint; reason: ptr cstring;
                          location: ptr ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Caller has the responsibility to destroy 'reason' (GEOSFree)
                         ##    and 'location' (GEOSGeom_destroy) params
                         ##    return 2 on exception, 1 when valid, 0 when invalid
                         ## ```
proc GEOSMakeValid_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomType_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cstring {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   *********************************************************************
                                  ##   
                                  ##     Geometry info
                                  ##   
                                  ##   ********************************************************************
                                  ##      Return NULL on exception, result must be freed by caller.
                                  ## ```
proc GEOSGeomTypeId_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return -1 on exception
                                  ## ```
proc GEOSGetSRID_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return 0 on exception
                                  ## ```
proc GEOSSetSRID_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry; SRID: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_getUserData_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): pointer {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_setUserData_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                             userData: pointer) {.importc, cdecl, impgeos_cDyn.}
proc GEOSGetNumGeometries_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   May be called on all geometries in GEOS 3.x, returns -1 on error and 1
                                  ##    for non-multi geometries. Older GEOS versions only accept
                                  ##    GeometryCollections or Multi* geometries here, and are likely to crash
                                  ##    when fed simple geometries, so beware if you need compatibility with
                                  ##    old GEOS versions.
                                  ## ```
proc GEOSGetGeometryN_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                         n: cint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return NULL on exception.
                  ##    Returned object is a pointer to internal storage:
                  ##    it must NOT be destroyed directly.
                  ##    Up to GEOS 3.2.0 the input geometry must be a Collection, in
                  ##    later version it doesn't matter (getGeometryN(0) for a single will
                  ##    return the input).
                  ## ```
proc GEOSNormalize_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return -1 on exception
                                  ## ```
proc GEOSGeom_setPrecision_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                              gridSize: cdouble; flags: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Set the geometry's precision, optionally rounding all its
                                  ##    coordinates to the precision grid (if it changes).
                                  ##   
                                  ##    Note that operations will always be performed in the precision
                                  ##    of the geometry with higher precision (smaller "gridSize").
                                  ##    That same precision will be attached to the operation outputs.
                                  ##   
                                  ##    @param gridSize size of the precision grid, or 0 for FLOATING
                                  ##                    precision.
                                  ##    @param flags The bitwise OR of one of more of the
                                  ##                 @ref GEOS_PREC_NO_TOPO "precision options"
                                  ##    @retuns NULL on exception or a new GEOSGeometry object
                                  ## ```
proc GEOSGeom_getPrecision_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cdouble {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Get a geometry's precision
                                  ##   
                                  ##    @return the size of the geometry's precision grid, 0 for FLOATING
                                  ##            precision or -1 on exception
                                  ## ```
proc GEOSGetNumInteriorRings_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return -1 on exception
                                  ## ```
proc GEOSGeomGetNumPoints_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return -1 on exception, Geometry must be a LineString.
                                  ## ```
proc GEOSGeomGetX_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                     x: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                           ##   Return 0 on exception, otherwise 1, Geometry must be a Point.
                                                                           ## ```
proc GEOSGeomGetY_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                     y: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSGeomGetZ_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                     z: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSGetInteriorRingN_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                             n: cint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return NULL on exception, Geometry must be a Polygon.
                  ##    Returned object is a pointer to internal storage:
                  ##    it must NOT be destroyed directly.
                  ## ```
proc GEOSGetExteriorRing_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception, Geometry must be a Polygon.
                                  ##    Returned object is a pointer to internal storage:
                                  ##    it must NOT be destroyed directly.
                                  ## ```
proc GEOSGetNumCoordinates_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return -1 on exception
                                  ## ```
proc GEOSGeom_getCoordSeq_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception.
                                  ##    Geometry must be a LineString, LinearRing or Point.
                                  ## ```
proc GEOSGeom_getDimensions_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return 0 on exception (or empty geometry)
                                  ## ```
proc GEOSGeom_getCoordinateDimension_r*(handle: GEOSContextHandle_t;
                                        g: ptr GEOSGeometry): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return 2 or 3.
                         ## ```
proc GEOSGeom_getXMin_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                         value: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return 0 on exception
                  ## ```
proc GEOSGeom_getYMin_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                         value: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_getXMax_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                         value: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_getYMax_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                         value: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomGetPointN_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                          n: cint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return NULL on exception.
                  ##    Must be LineString and must be freed by called.
                  ## ```
proc GEOSGeomGetStartPoint_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomGetEndPoint_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSArea_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                 area: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                          ##   *********************************************************************
                                                                          ##   
                                                                          ##     Misc functions
                                                                          ##   
                                                                          ##   ********************************************************************
                                                                          ##      Return 0 on exception, 1 otherwise
                                                                          ## ```
proc GEOSLength_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                   length: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSDistance_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                     g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSDistanceIndexed_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                            g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSHausdorffDistance_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                              g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSHausdorffDistanceDensify_r*(handle: GEOSContextHandle_t;
                                     g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                     densifyFrac: cdouble; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSFrechetDistance_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                            g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSFrechetDistanceDensify_r*(handle: GEOSContextHandle_t;
                                   g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                   densifyFrac: cdouble; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomGetLength_r*(handle: GEOSContextHandle_t; g: ptr GEOSGeometry;
                          length: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSNearestPoints_r*(handle: GEOSContextHandle_t; g1: ptr GEOSGeometry;
                          g2: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return 0 on exception, the closest points of the two geometries otherwise.
                                  ##    The first point comes from g1 geometry and the second point comes from g2.
                                  ## ```
proc GEOSOrientationIndex_r*(handle: GEOSContextHandle_t; Ax: cdouble;
                             Ay: cdouble; Bx: cdouble; By: cdouble; Px: cdouble;
                             Py: cdouble): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   *********************************************************************
                                                                                ##   
                                                                                ##    Algorithms
                                                                                ##   
                                                                                ##   ********************************************************************
                                                                                ##      Walking from A to B:
                                                                                ##     return -1 if reaching P takes a counter-clockwise (left) turn
                                                                                ##     return  1 if reaching P takes a clockwise (right) turn
                                                                                ##     return  0 if P is collinear with A-B
                                                                                ##   
                                                                                ##    On exceptions, return 2.
                                                                                ## ```
proc GEOSWKTReader_create_r*(handle: GEOSContextHandle_t): ptr GEOSWKTReader {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   WKT Reader
                                  ## ```
proc GEOSWKTReader_destroy_r*(handle: GEOSContextHandle_t;
                              reader: ptr GEOSWKTReader) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKTReader_read_r*(handle: GEOSContextHandle_t;
                           reader: ptr GEOSWKTReader; wkt: cstring): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_create_r*(handle: GEOSContextHandle_t): ptr GEOSWKTWriter {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   WKT Writer
                                  ## ```
proc GEOSWKTWriter_destroy_r*(handle: GEOSContextHandle_t;
                              writer: ptr GEOSWKTWriter) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKTWriter_write_r*(handle: GEOSContextHandle_t;
                            writer: ptr GEOSWKTWriter; g: ptr GEOSGeometry): cstring {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setTrim_r*(handle: GEOSContextHandle_t;
                              writer: ptr GEOSWKTWriter; trim: cchar) {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setRoundingPrecision_r*(handle: GEOSContextHandle_t;
    writer: ptr GEOSWKTWriter; precision: cint) {.importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setOutputDimension_r*(handle: GEOSContextHandle_t;
    writer: ptr GEOSWKTWriter; dim: cint) {.importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_getOutputDimension_r*(handle: GEOSContextHandle_t;
    writer: ptr GEOSWKTWriter): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setOld3D_r*(handle: GEOSContextHandle_t;
                               writer: ptr GEOSWKTWriter; useOld3D: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKBReader_create_r*(handle: GEOSContextHandle_t): ptr GEOSWKBReader {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   WKB Reader
                                  ## ```
proc GEOSWKBReader_destroy_r*(handle: GEOSContextHandle_t;
                              reader: ptr GEOSWKBReader) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBReader_read_r*(handle: GEOSContextHandle_t;
                           reader: ptr GEOSWKBReader; wkb: ptr cuchar;
                           size: uint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBReader_readHEX_r*(handle: GEOSContextHandle_t;
                              reader: ptr GEOSWKBReader; hex: ptr cuchar;
                              size: uint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_create_r*(handle: GEOSContextHandle_t): ptr GEOSWKBWriter {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   WKB Writer
                                  ## ```
proc GEOSWKBWriter_destroy_r*(handle: GEOSContextHandle_t;
                              writer: ptr GEOSWKBWriter) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_write_r*(handle: GEOSContextHandle_t;
                            writer: ptr GEOSWKBWriter; g: ptr GEOSGeometry;
                            size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   The caller owns the results for these two methods!
                  ## ```
proc GEOSWKBWriter_writeHEX_r*(handle: GEOSContextHandle_t;
                               writer: ptr GEOSWKBWriter; g: ptr GEOSGeometry;
                               size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_getOutputDimension_r*(handle: GEOSContextHandle_t;
    writer: ptr GEOSWKBWriter): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                     ##   Specify whether output WKB should be 2d or 3d.
                                                                     ##    Return previously set number of dimensions.
                                                                     ## ```
proc GEOSWKBWriter_setOutputDimension_r*(handle: GEOSContextHandle_t;
    writer: ptr GEOSWKBWriter; newDimension: cint) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_getByteOrder_r*(handle: GEOSContextHandle_t;
                                   writer: ptr GEOSWKBWriter): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Specify whether the WKB byte order is big or little endian.
                         ##    The return value is the previous byte order.
                         ## ```
proc GEOSWKBWriter_setByteOrder_r*(handle: GEOSContextHandle_t;
                                   writer: ptr GEOSWKBWriter; byteOrder: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKBWriter_getIncludeSRID_r*(handle: GEOSContextHandle_t;
                                     writer: ptr GEOSWKBWriter): cchar {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Specify whether SRID values should be output.
                                  ## ```
proc GEOSWKBWriter_setIncludeSRID_r*(handle: GEOSContextHandle_t;
                                     writer: ptr GEOSWKBWriter; writeSRID: cchar) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSFree_r*(handle: GEOSContextHandle_t; buffer: pointer) {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Free buffers returned by stuff like GEOSWKBWriter_write(),
                  ##    GEOSWKBWriter_writeHEX() and GEOSWKTWriter_write().
                  ## ```
proc initGEOS*(notice_function: GEOSMessageHandler;
               error_function: GEOSMessageHandler) {.importc, cdecl,
    impgeos_cDyn.}
proc finishGEOS*() {.importc, cdecl, impgeos_cDyn.}
proc GEOSGeomFromWKT*(wkt: cstring): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomToWKT*(g: ptr GEOSGeometry): cstring {.importc, cdecl, impgeos_cDyn.}
proc GEOS_getWKBOutputDims*(): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                    ##   Specify whether output WKB should be 2d or 3d.
                                                                    ##    Return previously set number of dimensions.
                                                                    ## ```
proc GEOS_setWKBOutputDims*(newDims: cint): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOS_getWKBByteOrder*(): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                   ##   Specify whether the WKB byte order is big or little endian.
                                                                   ##    The return value is the previous byte order.
                                                                   ## ```
proc GEOS_setWKBByteOrder*(byteOrder: cint): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSGeomFromWKB_buf*(wkb: ptr cuchar; size: uint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomToWKB_buf*(g: ptr GEOSGeometry; size: ptr uint): ptr cuchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomFromHEX_buf*(hex: ptr cuchar; size: uint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomToHEX_buf*(g: ptr GEOSGeometry; size: ptr uint): ptr cuchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_create*(size: cuint; dims: cuint): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   *********************************************************************
                                  ##   
                                  ##    Coordinate Sequence functions
                                  ##   
                                  ##   ********************************************************************
                                  ##     
                                  ##    Create a Coordinate sequence with size'' coordinates
                                  ##    of dims'' dimensions.
                                  ##    Return NULL on exception.
                                  ## ```
proc GEOSCoordSeq_clone*(s: ptr GEOSCoordSequence): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Clone a Coordinate Sequence.
                                  ##    Return NULL on exception.
                                  ## ```
proc GEOSCoordSeq_destroy*(s: ptr GEOSCoordSequence) {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Destroy a Coordinate Sequence.
                  ## ```
proc GEOSCoordSeq_setX*(s: ptr GEOSCoordSequence; idx: cuint; val: cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Set ordinate values in a Coordinate Sequence.
                                  ##    Return 0 on exception.
                                  ## ```
proc GEOSCoordSeq_setY*(s: ptr GEOSCoordSequence; idx: cuint; val: cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_setZ*(s: ptr GEOSCoordSequence; idx: cuint; val: cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_setXY*(s: ptr GEOSCoordSequence; idx: cuint; x: cdouble;
                         y: cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_setXYZ*(s: ptr GEOSCoordSequence; idx: cuint; x: cdouble;
                          y: cdouble; z: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_setOrdinate*(s: ptr GEOSCoordSequence; idx: cuint; dim: cuint;
                               val: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_getX*(s: ptr GEOSCoordSequence; idx: cuint; val: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Get ordinate values from a Coordinate Sequence.
                                  ##    Return 0 on exception.
                                  ## ```
proc GEOSCoordSeq_getY*(s: ptr GEOSCoordSequence; idx: cuint; val: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getZ*(s: ptr GEOSCoordSequence; idx: cuint; val: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getXY*(s: ptr GEOSCoordSequence; idx: cuint; x: ptr cdouble;
                         y: ptr cdouble): cint {.importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getXYZ*(s: ptr GEOSCoordSequence; idx: cuint; x: ptr cdouble;
                          y: ptr cdouble; z: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_getOrdinate*(s: ptr GEOSCoordSequence; idx: cuint; dim: cuint;
                               val: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSCoordSeq_getSize*(s: ptr GEOSCoordSequence; size: ptr cuint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Get size and dimensions info from a Coordinate Sequence.
                                  ##    Return 0 on exception.
                                  ## ```
proc GEOSCoordSeq_getDimensions*(s: ptr GEOSCoordSequence; dims: ptr cuint): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoordSeq_isCCW*(s: ptr GEOSCoordSequence; is_ccw: cstring): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Check orientation of a CoordinateSequence and set 'is_ccw' to 1
                                  ##    if it has counter-clockwise orientation, 0 otherwise.
                                  ##    Return 0 on exception, 1 on success.
                                  ## ```
proc GEOSProject*(g: ptr GEOSGeometry; p: ptr GEOSGeometry): cdouble {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   *********************************************************************
                         ##   
                         ##     Linear referencing functions -- there are more, but these are
                         ##     probably sufficient for most purposes
                         ##   
                         ##   ********************************************************************
                         ##     
                         ##    GEOSGeometry ownership is retained by caller
                         ##    
                         ##      Return distance of point 'p' projected on 'g' from origin
                         ##    of 'g'. Geometry 'g' must be a lineal geometry.
                         ##    Return -1 on exception
                         ## ```
proc GEOSInterpolate*(g: ptr GEOSGeometry; d: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return closest point to given distance within geometry
                                  ##    Geometry must be a LineString
                                  ## ```
proc GEOSProjectNormalized*(g: ptr GEOSGeometry; p: ptr GEOSGeometry): cdouble {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSInterpolateNormalized*(g: ptr GEOSGeometry; d: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSBuffer*(g: ptr GEOSGeometry; width: cdouble; quadsegs: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   *********************************************************************
                                  ##   
                                  ##    Buffer related functions
                                  ##   
                                  ##   ********************************************************************
                                  ##      @return NULL on exception
                                  ## ```
proc GEOSBufferParams_create*(): ptr GEOSBufferParams {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   @return 0 on exception
                  ## ```
proc GEOSBufferParams_destroy*(parms: ptr GEOSBufferParams) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSBufferParams_setEndCapStyle*(p: ptr GEOSBufferParams; style: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return 0 on exception
                                  ## ```
proc GEOSBufferParams_setJoinStyle*(p: ptr GEOSBufferParams; joinStyle: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @return 0 on exception
                                  ## ```
proc GEOSBufferParams_setMitreLimit*(p: ptr GEOSBufferParams;
                                     mitreLimit: cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   @return 0 on exception
                         ## ```
proc GEOSBufferParams_setQuadrantSegments*(p: ptr GEOSBufferParams;
    quadSegs: cint): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                          ##   @return 0 on exception
                                                          ## ```
proc GEOSBufferParams_setSingleSided*(p: ptr GEOSBufferParams; singleSided: cint): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   @param singleSided: 1 for single sided, 0 otherwise 
                                  ##      @return 0 on exception
                                  ## ```
proc GEOSBufferWithParams*(g: ptr GEOSGeometry; p: ptr GEOSBufferParams;
                           width: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   @return NULL on exception
                  ## ```
proc GEOSBufferWithStyle*(g: ptr GEOSGeometry; width: cdouble; quadsegs: cint;
                          endCapStyle: cint; joinStyle: cint;
                          mitreLimit: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   These functions return NULL on exception.
                         ## ```
proc GEOSSingleSidedBuffer*(g: ptr GEOSGeometry; width: cdouble; quadsegs: cint;
                            joinStyle: cint; mitreLimit: cdouble; leftSide: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   These functions return NULL on exception. Only LINESTRINGs are accepted. 
                                  ##      @deprecated in 3.3.0: use GEOSOffsetCurve instead
                                  ## ```
proc GEOSOffsetCurve*(g: ptr GEOSGeometry; width: cdouble; quadsegs: cint;
                      joinStyle: cint; mitreLimit: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Only LINESTRINGs are accepted.
                                  ##    @param width : offset distance.
                                  ##                   negative for right side offset.
                                  ##                   positive for left side offset.
                                  ##    @return NULL on exception
                                  ## ```
proc GEOSGeom_createPoint*(s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createPointFromXY*(x: cdouble; y: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyPoint*(): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_createLinearRing*(s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createLineString*(s: ptr GEOSCoordSequence): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyLineString*(): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_createEmptyPolygon*(): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Second argument is an array of GEOSGeometry* objects.
                  ##    The caller remains owner of the array, but pointed-to
                  ##    objects become ownership of the returned GEOSGeometry.
                  ## ```
proc GEOSGeom_createPolygon*(shell: ptr GEOSGeometry;
                             holes: ptr ptr GEOSGeometry; nholes: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_createCollection*(`type`: cint; geoms: ptr ptr GEOSGeometry;
                                ngeoms: cuint): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeom_createEmptyCollection*(`type`: cint): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeom_clone*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_destroy*(g: ptr GEOSGeometry) {.importc, cdecl, impgeos_cDyn.}
proc GEOSEnvelope*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSIntersection*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSIntersectionPrec*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                           gridSize: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSConvexHull*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSMinimumRotatedRectangle*(g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Returns the minimum rotated rectangular POLYGON which encloses the input geometry. The rectangle
                                  ##    has width equal to the minimum diameter, and a longer length. If the convex hill of the input is
                                  ##    degenerate (a line or point) a LINESTRING or POINT is returned. The minimum rotated rectangle can
                                  ##    be used as an extremely generalized representation for the given geometry.
                                  ## ```
proc GEOSMaximumInscribedCircle*(g: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Constructs the Maximum Inscribed Circle for a  polygonal geometry, up to a specified tolerance.
                                  ##    The Maximum Inscribed Circle is determined by a point in the interior of the area
                                  ##    which has the farthest distance from the area boundary, along with a boundary point at that distance.
                                  ##    In the context of geography the center of the Maximum Inscribed Circle is known as the
                                  ##    Pole of Inaccessibility. A cartographic use case is to determine a suitable point
                                  ##    to place a map label within a polygon.
                                  ##    The radius length of the Maximum Inscribed Circle is a  measure of how "narrow" a polygon is. It is the
                                  ##    distance at which the negative buffer becomes empty.
                                  ##    The class supports polygons with holes and multipolygons.
                                  ##    The implementation uses a successive-approximation technique over a grid of square cells covering the area geometry.
                                  ##    The grid is refined using a branch-and-bound algorithm. Point containment and distance are computed in a performant
                                  ##    way by using spatial indexes.
                                  ##    Returns a two-point linestring, with one point at the center of the inscribed circle and the other
                                  ##    on the boundary of the inscribed circle.
                                  ## ```
proc GEOSLargestEmptyCircle*(g: ptr GEOSGeometry; boundary: ptr GEOSGeometry;
                             tolerance: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Constructs the Largest Empty Circle for a set of obstacle geometries, up to a
                         ##    specified tolerance. The obstacles are point and line geometries.
                         ##    The Largest Empty Circle is the largest circle which  has its center in the convex hull of the
                         ##    obstacles (the boundary), and whose interior does not intersect with any obstacle.
                         ##    The circle center is the point in the interior of the boundary which has the farthest distance from
                         ##    the obstacles (up to tolerance). The circle is determined by the center point and a point lying on an
                         ##    obstacle indicating the circle radius.
                         ##    The implementation uses a successive-approximation technique over a grid of square cells covering the obstacles and boundary.
                         ##    The grid is refined using a branch-and-bound algorithm.  Point containment and distance are computed in a performant
                         ##    way by using spatial indexes.
                         ##    Returns a two-point linestring, with one point at the center of the inscribed circle and the other
                         ##    on the boundary of the inscribed circle.
                         ## ```
proc GEOSMinimumWidth*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Returns a LINESTRING geometry which represents the minimum diameter of the geometry.
                  ##    The minimum diameter is defined to be the width of the smallest band that
                  ##    contains the geometry, where a band is a strip of the plane defined
                  ##    by two parallel lines. This can be thought of as the smallest hole that the geometry
                  ##    can be moved through, with a single rotation.
                  ## ```
proc GEOSMinimumClearance*(g: ptr GEOSGeometry; d: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Computes the minimum clearance of a geometry.  The minimum clearance is the smallest amount by which
                         ##    a vertex could be move to produce an invalid polygon, a non-simple linestring, or a multipoint with
                         ##    repeated points.  If a geometry has a minimum clearance of 'eps', it can be said that:
                         ##   
                         ##    -  No two distinct vertices in the geometry are separated by less than 'eps'
                         ##    -  No vertex is closer than 'eps' to a line segment of which it is not an endpoint.
                         ##   
                         ##    If the minimum clearance cannot be defined for a geometry (such as with a single point, or a multipoint
                         ##    whose points are identical, a value of Infinity will be calculated.
                         ##   
                         ##    @param g the input geometry
                         ##    @param d a double to which the result can be stored
                         ##   
                         ##    @return 0 if no exception occurred
                         ##            2 if an exception occurred
                         ## ```
proc GEOSMinimumClearanceLine*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Returns a LineString whose endpoints define the minimum clearance of a geometry.
                         ##    If the geometry has no minimum clearance, an empty LineString will be returned.
                         ##   
                         ##    @param g the input geometry
                         ##    @return a LineString, or NULL if an exception occurred.
                         ## ```
proc GEOSDifference*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSDifferencePrec*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                         gridSize: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSSymDifference*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSSymDifferencePrec*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                            gridSize: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSBoundary*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSUnion*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSUnionPrec*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                    gridSize: cdouble): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSUnaryUnion*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSUnaryUnionPrec*(g: ptr GEOSGeometry; gridSize: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCoverageUnion*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   GEOSCoverageUnion is an optimized union algorithm for polygonal inputs that are correctly
                  ##    noded and do not overlap. It will not generate an error (return NULL) for inputs that
                  ##    do not satisfy this constraint.
                  ## ```
proc GEOSUnionCascaded*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   @deprecated in 3.3.0: use GEOSUnaryUnion instead
                  ## ```
proc GEOSPointOnSurface*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGetCentroid*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSMinimumBoundingCircle*(g: ptr GEOSGeometry; radius: ptr cdouble;
                                center: ptr ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSNode*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSClipByRect*(g: ptr GEOSGeometry; xmin: cdouble; ymin: cdouble;
                     xmax: cdouble; ymax: cdouble): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSPolygonize*(geoms: GEOSGeometry; ngeoms: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   all arguments remain ownership of the caller
                                  ##    (both Geometries and pointers)
                                  ## ```
proc GEOSPolygonize_valid*(geoms: GEOSGeometry; ngeoms: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPolygonizer_getCutEdges*(geoms: GEOSGeometry; ngeoms: cuint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPolygonize_full*(input: ptr GEOSGeometry; cuts: ptr ptr GEOSGeometry;
                          dangles: ptr ptr GEOSGeometry;
                          invalid: ptr ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSBuildArea*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSLineMerge*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSReverse*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSSimplify*(g: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSTopologyPreserveSimplify*(g: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeom_extractUniquePoints*(g: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return all distinct vertices of input geometry as a MULTIPOINT.
                                  ##    Note that only 2 dimensions of the vertices are considered when
                                  ##    testing for equality.
                                  ## ```
proc GEOSSharedPaths*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Find paths shared between the two given lineal geometries.
                                  ##   
                                  ##    Returns a GEOMETRYCOLLECTION having two elements:
                                  ##    - first element is a MULTILINESTRING containing shared paths
                                  ##      having the _same_ direction on both inputs
                                  ##    - second element is a MULTILINESTRING containing shared paths
                                  ##      having the _opposite_ direction on the two inputs
                                  ##   
                                  ##    Returns NULL on exception
                                  ## ```
proc GEOSSnap*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry; tolerance: cdouble): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Snap first geometry on to second with given tolerance
                                  ##    Returns a newly allocated geometry, or NULL on exception
                                  ## ```
proc GEOSDelaunayTriangulation*(g: ptr GEOSGeometry; tolerance: cdouble;
                                onlyEdges: cint): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return a Delaunay triangulation of the vertex of the given geometry
                         ##   
                         ##    @param g the input geometry whose vertex will be used as "sites"
                         ##    @param tolerance optional snapping tolerance to use for improved robustness
                         ##    @param onlyEdges if non-zero will return a MULTILINESTRING, otherwise it will
                         ##                     return a GEOMETRYCOLLECTION containing triangular POLYGONs.
                         ##   
                         ##    @return  a newly allocated geometry, or NULL on exception
                         ## ```
proc GEOSVoronoiDiagram*(g: ptr GEOSGeometry; env: ptr GEOSGeometry;
                         tolerance: cdouble; onlyEdges: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Returns the Voronoi polygons of a set of Vertices given as input
                                  ##   
                                  ##    @param g the input geometry whose vertex will be used as sites.
                                  ##    @param tolerance snapping tolerance to use for improved robustness
                                  ##    @param onlyEdges whether to return only edges of the voronoi cells
                                  ##    @param env clipping envelope for the returned diagram, automatically
                                  ##               determined if NULL.
                                  ##               The diagram will be clipped to the larger
                                  ##               of this envelope or an envelope surrounding the sites.
                                  ##   
                                  ##    @return a newly allocated geometry, or NULL on exception.
                                  ## ```
proc GEOSSegmentIntersection*(ax0: cdouble; ay0: cdouble; ax1: cdouble;
                              ay1: cdouble; bx0: cdouble; by0: cdouble;
                              bx1: cdouble; by1: cdouble; cx: ptr cdouble;
                              cy: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSDisjoint*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSTouches*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSIntersects*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSCrosses*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSWithin*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSContains*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSOverlaps*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSEquals*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCovers*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSCoveredBy*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSEqualsExact*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                      tolerance: cdouble): cchar {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                 ##   Determine pointwise equivalence of two geometries, by checking if each vertex of g2 is
                                                                                 ##    within tolerance of the corresponding vertex in g1.
                                                                                 ##    Unlike GEOSEquals, geometries that are topologically equivalent but have different
                                                                                 ##    representations (e.g., LINESTRING (0 0, 1 1) and MULTILINESTRING ((0 0, 1 1)) ) are not
                                                                                 ##    considered equivalent by GEOSEqualsExact.
                                                                                 ##    returns 2 on exception, 1 on true, 0 on false
                                                                                 ## ```
proc GEOSPrepare*(g: ptr GEOSGeometry): ptr GEOSPreparedGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   *********************************************************************
                         ##   
                         ##     Prepared Geometry Binary predicates - return 2 on exception, 1 on true, 0 on false
                         ##   
                         ##   ********************************************************************
                         ##     
                         ##    GEOSGeometry ownership is retained by caller
                         ## ```
proc GEOSPreparedGeom_destroy*(g: ptr GEOSPreparedGeometry) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSPreparedContains*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedContainsProperly*(pg1: ptr GEOSPreparedGeometry;
                                   g2: ptr GEOSGeometry): cchar {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSPreparedCoveredBy*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedCovers*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedCrosses*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedDisjoint*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedIntersects*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedOverlaps*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedTouches*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedWithin*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry): cchar {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedNearestPoints*(pg1: ptr GEOSPreparedGeometry;
                                g2: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSPreparedDistance*(pg1: ptr GEOSPreparedGeometry; g2: ptr GEOSGeometry;
                           dist: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSSTRtree_create*(nodeCapacity: uint): ptr GEOSSTRtree {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   *********************************************************************
                  ##   
                  ##     STRtree functions
                  ##   
                  ##   ********************************************************************
                  ##     
                  ##    GEOSGeometry ownership is retained by caller
                  ##    
                  ##     
                  ##    Create a new R-tree using the Sort-Tile-Recursive algorithm (STRtree) for two-dimensional
                  ##    spatial data.
                  ##   
                  ##    @param nodeCapacity the maximum number of child nodes that a node may have.  The minimum
                  ##               recommended capacity value is 4.  If unsure, use a default node capacity of 10.
                  ##    @return a pointer to the created tree
                  ## ```
proc GEOSSTRtree_insert*(tree: ptr GEOSSTRtree; g: ptr GEOSGeometry;
                         item: pointer) {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                        ##   Insert an item into an STRtree
                                                                        ##   
                                                                        ##    @param tree the STRtree in which the item should be inserted
                                                                        ##    @param g a GEOSGeometry whose envelope corresponds to the extent of 'item'
                                                                        ##    @param item the item to insert into the tree
                                                                        ## ```
proc GEOSSTRtree_query*(tree: ptr GEOSSTRtree; g: ptr GEOSGeometry;
                        callback: GEOSQueryCallback; userdata: pointer) {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Query an STRtree for items intersecting a specified envelope
                                  ##   
                                  ##    @param tree the STRtree to search
                                  ##    @param g a GEOSGeomety from which a query envelope will be extracted
                                  ##    @param callback a function to be executed for each item in the tree whose envelope intersects
                                  ##               the envelope of 'g'.  The callback function should take two parameters: a void
                                  ##               pointer representing the located item in the tree, and a void userdata pointer.
                                  ##    @param userdata an optional pointer to pe passed to 'callback' as an argument
                                  ## ```
proc GEOSSTRtree_nearest*(tree: ptr GEOSSTRtree; geom: ptr GEOSGeometry): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Returns the nearest item in the STRtree to the supplied GEOSGeometry.
                                  ##    All items in the tree MUST be of type GEOSGeometry.  If this is not the case, use
                                  ##    GEOSSTRtree_nearest_generic instead.
                                  ##  
                                  ##    @param tree the STRtree to search
                                  ##    @param geom the geometry with which the tree should be queried
                                  ##    @return a const pointer to the nearest GEOSGeometry in the tree to 'geom', or NULL in
                                  ##               case of exception
                                  ## ```
proc GEOSSTRtree_nearest_generic*(tree: ptr GEOSSTRtree; item: pointer;
                                  itemEnvelope: ptr GEOSGeometry;
                                  distancefn: GEOSDistanceCallback;
                                  userdata: pointer): pointer {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Returns the nearest item in the STRtree to the supplied item
                  ##   
                  ##    @param tree the STRtree to search
                  ##    @param item the item with which the tree should be queried
                  ##    @param itemEnvelope a GEOSGeometry having the bounding box of 'item'
                  ##    @param distancefn a function that can compute the distance between two items
                  ##               in the STRtree.  The function should return zero in case of error,
                  ##               and should store the computed distance to the location pointed to by
                  ##               the 'distance' argument.  The computed distance between two items
                  ##               must not exceed the Cartesian distance between their envelopes.
                  ##    @param userdata optional pointer to arbitrary data; will be passed to distancefn
                  ##               each time it is called.
                  ##    @return a const pointer to the nearest item in the tree to 'item', or NULL in
                  ##               case of exception
                  ## ```
proc GEOSSTRtree_iterate*(tree: ptr GEOSSTRtree; callback: GEOSQueryCallback;
                          userdata: pointer) {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                             ##   Iterates over all items in the STRtree
                                                                             ##   
                                                                             ##    @param tree the STRtree over which to iterate
                                                                             ##    @param callback a function to be executed for each item in the tree.
                                                                             ## ```
proc GEOSSTRtree_remove*(tree: ptr GEOSSTRtree; g: ptr GEOSGeometry;
                         item: pointer): cchar {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                               ##   Removes an item from the STRtree
                                                                               ##   
                                                                               ##    @param tree the STRtree from which to remove an item
                                                                               ##    @param g the envelope of the item to remove
                                                                               ##    @param the item to remove
                                                                               ##    @return 0 if the item was not removed;
                                                                               ##            1 if the item was removed;
                                                                               ##            2 if an exception occurred
                                                                               ## ```
proc GEOSSTRtree_destroy*(tree: ptr GEOSSTRtree) {.importc, cdecl, impgeos_cDyn.}
proc GEOSisEmpty*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSisSimple*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSisRing*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSHasZ*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSisClosed*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
proc GEOSRelatePattern*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry; pat: cstring): cchar {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   *********************************************************************
                                  ##   
                                  ##     Dimensionally Extended 9 Intersection Model related
                                  ##   
                                  ##   ********************************************************************
                                  ##      return 2 on exception, 1 on true, 0 on false
                                  ## ```
proc GEOSRelate*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): cstring {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   return NULL on exception, a string to GEOSFree otherwise
                         ## ```
proc GEOSRelatePatternMatch*(mat: cstring; pat: cstring): cchar {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   return 2 on exception, 1 on true, 0 on false
                         ## ```
proc GEOSRelateBoundaryNodeRule*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                 bnr: cint): cstring {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   return NULL on exception, a string to GEOSFree otherwise
                  ## ```
proc GEOSisValid*(g: ptr GEOSGeometry): cchar {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                              ##   *********************************************************************
                                                                              ##   
                                                                              ##     Validity checking
                                                                              ##   
                                                                              ##   ********************************************************************
                                                                              ##      return 2 on exception, 1 on true, 0 on false
                                                                              ## ```
proc GEOSisValidReason*(g: ptr GEOSGeometry): cstring {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   return NULL on exception, a string to GEOSFree otherwise
                  ## ```
proc GEOSisValidDetail*(g: ptr GEOSGeometry; flags: cint; reason: ptr cstring;
                        location: ptr ptr GEOSGeometry): cchar {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Caller has the responsibility to destroy 'reason' (GEOSFree)
                  ##    and 'location' (GEOSGeom_destroy) params
                  ##    return 2 on exception, 1 when valid, 0 when invalid
                  ##    Use enum GEOSValidFlags values for the flags param.
                  ## ```
proc GEOSMakeValid*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomType*(g: ptr GEOSGeometry): cstring {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                 ##   *********************************************************************
                                                                                 ##   
                                                                                 ##     Geometry info
                                                                                 ##   
                                                                                 ##   ********************************************************************
                                                                                 ##      Return NULL on exception, result must be freed by caller.
                                                                                 ## ```
proc GEOSGeomTypeId*(g: ptr GEOSGeometry): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   Return -1 on exception
                                                                                ## ```
proc GEOSGetSRID*(g: ptr GEOSGeometry): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                             ##   Return 0 on exception
                                                                             ## ```
proc GEOSSetSRID*(g: ptr GEOSGeometry; SRID: cint) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_getUserData*(g: ptr GEOSGeometry): pointer {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeom_setUserData*(g: ptr GEOSGeometry; userData: pointer) {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGetNumGeometries*(g: ptr GEOSGeometry): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   May be called on all geometries in GEOS 3.x, returns -1 on error and 1
                  ##    for non-multi geometries. Older GEOS versions only accept
                  ##    GeometryCollections or Multi* geometries here, and are likely to crash
                  ##    when fed simple geometries, so beware if you need compatibility with
                  ##    old GEOS versions.
                  ## ```
proc GEOSGetGeometryN*(g: ptr GEOSGeometry; n: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception.
                                  ##    Returned object is a pointer to internal storage:
                                  ##    it must NOT be destroyed directly.
                                  ##    Up to GEOS 3.2.0 the input geometry must be a Collection, in
                                  ##    later version it doesn't matter (getGeometryN(0) for a single will
                                  ##    return the input).
                                  ## ```
proc GEOSNormalize*(g: ptr GEOSGeometry): cint {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                               ##   Return -1 on exception
                                                                               ## ```
proc GEOSGeom_setPrecision*(g: ptr GEOSGeometry; gridSize: cdouble; flags: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception
                                  ## ```
proc GEOSGeom_getPrecision*(g: ptr GEOSGeometry): cdouble {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return -1 on exception
                  ## ```
proc GEOSGetNumInteriorRings*(g: ptr GEOSGeometry): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return -1 on exception
                  ## ```
proc GEOSGeomGetNumPoints*(g: ptr GEOSGeometry): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return -1 on exception, Geometry must be a LineString.
                  ## ```
proc GEOSGeomGetX*(g: ptr GEOSGeometry; x: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return 0 on exception, otherwise 1, Geometry must be a Point.
                  ## ```
proc GEOSGeomGetY*(g: ptr GEOSGeometry; y: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGeomGetZ*(g: ptr GEOSGeometry; z: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSGetInteriorRingN*(g: ptr GEOSGeometry; n: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception, Geometry must be a Polygon.
                                  ##    Returned object is a pointer to internal storage:
                                  ##    it must NOT be destroyed directly.
                                  ## ```
proc GEOSGetExteriorRing*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return NULL on exception, Geometry must be a Polygon.
                         ##    Returned object is a pointer to internal storage:
                         ##    it must NOT be destroyed directly.
                         ## ```
proc GEOSGetNumCoordinates*(g: ptr GEOSGeometry): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return -1 on exception
                  ## ```
proc GEOSGeom_getCoordSeq*(g: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception.
                                  ##    Geometry must be a LineString, LinearRing or Point.
                                  ## ```
proc GEOSGeom_getDimensions*(g: ptr GEOSGeometry): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   Return 0 on exception (or empty geometry)
                  ## ```
proc GEOSGeom_getCoordinateDimension*(g: ptr GEOSGeometry): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return 2 or 3.
                         ## ```
proc GEOSGeom_getXMin*(g: ptr GEOSGeometry; value: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Return 0 on exception
                         ## ```
proc GEOSGeom_getYMin*(g: ptr GEOSGeometry; value: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeom_getXMax*(g: ptr GEOSGeometry; value: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeom_getYMax*(g: ptr GEOSGeometry; value: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeomGetPointN*(g: ptr GEOSGeometry; n: cint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return NULL on exception.
                                  ##    Must be LineString and must be freed by called.
                                  ## ```
proc GEOSGeomGetStartPoint*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSGeomGetEndPoint*(g: ptr GEOSGeometry): ptr GEOSGeometry {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSArea*(g: ptr GEOSGeometry; area: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   *********************************************************************
                  ##   
                  ##     Misc functions
                  ##   
                  ##   ********************************************************************
                  ##      Return 0 on exception, 1 otherwise
                  ## ```
proc GEOSLength*(g: ptr GEOSGeometry; length: ptr cdouble): cint {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSDistance*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSDistanceIndexed*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                          dist: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSHausdorffDistance*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                            dist: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSHausdorffDistanceDensify*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                   densifyFrac: cdouble; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSFrechetDistance*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                          dist: ptr cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSFrechetDistanceDensify*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry;
                                 densifyFrac: cdouble; dist: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSGeomGetLength*(g: ptr GEOSGeometry; length: ptr cdouble): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSNearestPoints*(g1: ptr GEOSGeometry; g2: ptr GEOSGeometry): ptr GEOSCoordSequence {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Return 0 on exception, the closest points of the two geometries otherwise.
                                  ##    The first point comes from g1 geometry and the second point comes from g2.
                                  ## ```
proc GEOSOrientationIndex*(Ax: cdouble; Ay: cdouble; Bx: cdouble; By: cdouble;
                           Px: cdouble; Py: cdouble): cint {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   *********************************************************************
                  ##   
                  ##    Algorithms
                  ##   
                  ##   ********************************************************************
                  ##      Walking from A to B:
                  ##     return -1 if reaching P takes a counter-clockwise (left) turn
                  ##     return  1 if reaching P takes a clockwise (right) turn
                  ##     return  0 if P is collinear with A-B
                  ##   
                  ##    On exceptions, return 2.
                  ## ```
proc GEOSWKTReader_create*(): ptr GEOSWKTReader {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   *********************************************************************
                                                                                ##   
                                                                                ##    Reader and Writer APIs
                                                                                ##   
                                                                                ##   ********************************************************************
                                                                                ##      WKT Reader
                                                                                ## ```
proc GEOSWKTReader_destroy*(reader: ptr GEOSWKTReader) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKTReader_read*(reader: ptr GEOSWKTReader; wkt: cstring): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_create*(): ptr GEOSWKTWriter {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   WKT Writer
                                                                                ## ```
proc GEOSWKTWriter_destroy*(writer: ptr GEOSWKTWriter) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKTWriter_write*(writer: ptr GEOSWKTWriter; g: ptr GEOSGeometry): cstring {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setTrim*(writer: ptr GEOSWKTWriter; trim: cchar) {.importc,
    cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setRoundingPrecision*(writer: ptr GEOSWKTWriter;
    precision: cint) {.importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setOutputDimension*(writer: ptr GEOSWKTWriter; dim: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_getOutputDimension*(writer: ptr GEOSWKTWriter): cint {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKTWriter_setOld3D*(writer: ptr GEOSWKTWriter; useOld3D: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKBReader_create*(): ptr GEOSWKBReader {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   WKB Reader
                                                                                ## ```
proc GEOSWKBReader_destroy*(reader: ptr GEOSWKBReader) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBReader_read*(reader: ptr GEOSWKBReader; wkb: ptr cuchar; size: uint): ptr GEOSGeometry {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKBReader_readHEX*(reader: ptr GEOSWKBReader; hex: ptr cuchar;
                            size: uint): ptr GEOSGeometry {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_create*(): ptr GEOSWKBWriter {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                                ##   WKB Writer
                                                                                ## ```
proc GEOSWKBWriter_destroy*(writer: ptr GEOSWKBWriter) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_write*(writer: ptr GEOSWKBWriter; g: ptr GEOSGeometry;
                          size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
  ## ```
                  ##   The caller owns the results for these two methods!
                  ## ```
proc GEOSWKBWriter_writeHEX*(writer: ptr GEOSWKBWriter; g: ptr GEOSGeometry;
                             size: ptr uint): ptr cuchar {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_getOutputDimension*(writer: ptr GEOSWKBWriter): cint {.
    importc, cdecl, impgeos_cDyn.}
  ## ```
                                  ##   Specify whether output WKB should be 2d or 3d.
                                  ##    Return previously set number of dimensions.
                                  ## ```
proc GEOSWKBWriter_setOutputDimension*(writer: ptr GEOSWKBWriter;
                                       newDimension: cint) {.importc, cdecl,
    impgeos_cDyn.}
proc GEOSWKBWriter_getByteOrder*(writer: ptr GEOSWKBWriter): cint {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Specify whether the WKB byte order is big or little endian.
                         ##    The return value is the previous byte order.
                         ## ```
proc GEOSWKBWriter_setByteOrder*(writer: ptr GEOSWKBWriter; byteOrder: cint) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSWKBWriter_getIncludeSRID*(writer: ptr GEOSWKBWriter): cchar {.importc,
    cdecl, impgeos_cDyn.}
  ## ```
                         ##   Specify whether SRID values should be output.
                         ## ```
proc GEOSWKBWriter_setIncludeSRID*(writer: ptr GEOSWKBWriter; writeSRID: cchar) {.
    importc, cdecl, impgeos_cDyn.}
proc GEOSFree*(buffer: pointer) {.importc, cdecl, impgeos_cDyn.}
  ## ```
                                                                ##   Free buffers returned by stuff like GEOSWKBWriter_write(),
                                                                ##    GEOSWKBWriter_writeHEX() and GEOSWKTWriter_write().
                                                                ## ```
{.pop.}
