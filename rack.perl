#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Item', 'Remarks', 'Reference' ],
];
 
my $data = [
    [ 'Switch (Hub)', 'NETGEAR 16 Port Switch', '\href{https://www.netgear.com/support/product/jgs516.aspx}{JGS512 v2}' ],
	[ 'NIM crate', 'Large current type' ,'\href{https://www.h-repic.co.jp/products/module/crates_nim/rpn_005_153}{RPN-005-153}' ],
	[ 'VME crate', '\pbox{4cm}{special processing RPPV-2016W (without J2, rail positions changed)}' ,'???' ],
	[ 'Front-end DAQ PC', 'DAQ PC' ,'\href{https://www.dell.com/en-us/work/shop/productdetailstxn/poweredge-r330}{Dell PowerEdge R330 Rack Server}' ],
	[ 'Back-end Slow Control PC', 'ANA PC' ,'\href{https://www.dell.com/en-us/work/shop/povw/poweredge-r530}{Dell PowerEdge R530 Rack Server}' ],
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'rack.tex',
      maincaption => 'Items on the WAGASCI rack',
      label       => 'table:rack',
	  theme       => 'NYC3',
	  type        => 'xtab',
      header      => $header,
      data        => $data,
      }
	);

$table->set_coldef_strategy({
  NUMBER                =>
     qr{\A\s*([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?\s*\z}xms,
  NUMBER_MUST_MATCH_ALL => 1,
  NUMBER_COL            => 'c',
  LONG                  => qr{\A\s*(?=\w+\s+\w+).{29,}?\S}xms,
  LONG_MUST_MATCH_ALL   => 0,
  LONG_COL              => 'l',
  LONG_COL_X            => 'X',
  LONG_COL_Y            => 'L',
});
 
# write LaTeX code in prices.tex
$table->generate();
 
print $table->generate_string();
