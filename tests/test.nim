import unittest
import geos

test "reads and writes wkt":

  var context = GEOS_init_r()
  var reader = GEOSWKTReader_create_r(context)
  var writer = GEOSWKTWriter_create_r(context)
  GEOSWKTWriter_setRoundingPrecision_r(context, writer, 3)

  var geometry = GEOSWKTReader_read_r(context, reader, "POINT(1 1)")
  check GEOSWKTWriter_write_r(context, writer, geometry) == "POINT (1.000 1.000)"

  geometry = GEOSGeom_createPointFromXY_r(context, 1, 2)
  check GEOSWKTWriter_write_r(context, writer, geometry) == "POINT (1.000 2.000)"

  GEOSWKTWriter_destroy_r(context, writer)
  GEOSWKTReader_destroy_r(context, reader)
  GEOS_finish_r(context)
