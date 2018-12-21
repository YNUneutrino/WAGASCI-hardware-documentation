#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values

my $header = [
    [ 'Purpose', 'Cables/Connectors', '\#', 'Remarks', 'Reference' ],
];
 
my $data = [
	[ '\textbf{DIF data}', '50cm HDMI', '2', 'to DIF', 'Any cable is good' ],
	[ '\textbf{IF LV}', '50cm LV wire', '2', 'to IF LV', '\href{https://www.digikey.jp/product-detail/ja/alpha-wire/6305-SL005/A6305SL-100-ND/3714712}{Digi-Key A6305SL-100-ND}' ],
	[ '', 'MOLEX contacts', '10', 'to IF LV', '\href{https://jp.rs-online.com/web/p/pcb-connector-contacts/6706445}{RS 670-6445}' ],
	[ '', 'MOLEX housing', '2', 'to IF LV', '\href{https://jp.rs-online.com/web/p/pcb-connector-housings/6704174}{RS 670-4174}' ],
	[ '\textbf{DIF flash}', 'JTAG housing', '2', 'to DIF', '\href{https://jp.rs-online.com/web/p/pcb-connector-housings/6737626/}{RS 673-7626}' ],
	[ '', 'JTAG contacts', '20', 'to DIF', '\href{https://jp.rs-online.com/web/p/pcb-connector-contacts/7142404/}{RS 714-2404}' ],
	[ '\textbf{LED}', '15 wires cable', '2', 'Extra LED', '\href{https://www.digikey.jp/products/ja?keywords=ALPHA%20WIRE%20%203470/15C%20SL005}{3470/15C SL005}' ],
	[ '', 'ISDF  housing', '2', 'Extra LED', '\href{https://jp.rs-online.com/web/p/pcb-connector-housings/1800450/}{RS 180-0450}' ],
	[ '', 'ISDF contacts', '28', 'Extra LED', '\href{https://jp.rs-online.com/web/p/pcb-connector-contacts/1801564/}{RS 180-1564}' ],
	[ '\textbf{ASU}', '10cm 50-pin flat cable', '64', 'ASU-ASU', '\href{https://jp.rs-online.com/web/p/serial-cable-assemblies/9011848/}{RS 901-1848}' ],
	[ '', '22cm 50-pin flat cable', '16', 'ASU-IF', '\href{https://jp.rs-online.com/web/p/serial-cable-assemblies/9011857/}{RS 901-1857}' ],
	[ '\textbf{HV}', 'LEMO', '2', 'to IF HV', '\href{https://jp.rs-online.com/web/p/industrial-automation-circular-connectors/3202568}{RS 320-2568}' ],	
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'cables-internal.tex',
      maincaption => 'Cables and connectors for inside the housing',
      label       => 'table:cables-internal',
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
