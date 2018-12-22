#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Cables/Connectors', '\#', 'Remarks', 'Reference' ],
];
 
my $data = [
    [ 'Flat cable (34 wires)', '1', 'spill number (ECL signal)', '???' ],
	[ 'Hirose connector (10 pins)', '2', 'TTL input (on ZedBoard)', '\href{https://jp.rs-online.com/web/p/pcb-headers/8960809/}{RS 896-0809}' ],
	[ '8ch. LEMO - 10-pin flat cable', '2', 'TTL signal (to Pmod connector)', '???' ],
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'cables-beam-trigger.tex',
      maincaption => 'Cables for beam trigger and spill number processing',
      label       => 'table:cables-beam-trigger',
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
