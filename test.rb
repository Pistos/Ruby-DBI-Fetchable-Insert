require 'dbi'
require 'test/unit'

class DBITest < Test::Unit::TestCase

  def test_fetchable_insert
    dbh = DBI.connect( 'DBI:Pg:dbi_f_i', 'test' )
    assert_not_nil dbh
    assert dbh.connected?

    dbh.do "DELETE FROM t"

    inserted = dbh.do "INSERT INTO t ( data ) VALUES ( 'foo' );"
    assert( inserted > 0 )
    inserted = dbh.do "INSERT INTO t ( data ) VALUES ( 'foo' );"
    assert( inserted > 0 )

    rows = dbh.select_all "SELECT * FROM t"
    assert_equal( 2, rows.size )

    rows = dbh.select_all "INSERT INTO api__sub1 ( data ) VALUES ( 'foo' )"
    assert_equal( 3, rows.size )
  end

end