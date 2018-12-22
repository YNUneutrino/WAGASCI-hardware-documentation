#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Item', 'Remarks', 'Reference' ],
];
 
my $data = [
    [ 'PicoLog 1012', 'Water Level sensor probe', '\href{https://www.picotech.com/data-logger/picolog-1000-series/multi-channel-daq}{PicoLog 1012}' ],
	[ 'TDK 200W 80V 2.5A', 'HV PSU', '\href{https://product.tdk.com/en/search/power/switching-power/prg-power/info?part_no=ZUP80-2.5}{ZUP80-2.5}' ],
	[ 'TDK 200W 6V 33A', 'LV PSU', '\href{https://product.tdk.com/ja/search/power/switching-power/prg-power/info?part_no=ZUP6-33}{ZUP6-33}' ],
#	[ '', '', '\href{}{}' ],
#	[ '', '', '\href{}{}' ],
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'slow-control.tex',
      maincaption => 'Slow Control Items',
      label       => 'table:slow-control',
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
