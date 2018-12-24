#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Item', '\#', 'Remarks', 'Reference' ],
];
 
my $data = [
    [ 'DIF connector (housing)', '2', '8-contacts', '\href{https://jp.rs-online.com/web/p/pcb-connector-housings/6737626/}{RS 673-7626}' ],
	[ 'DIF connector (contacts)', '16', '', '\href{https://jp.rs-online.com/web/p/pcb-connector-contacts/7142404/?sra=pstk}{RS 714-2404}' ],
	[ 'Xilinx USB cable', '1', 'HW-USB-FLYLEADS-G', '\href{https://jp.rs-online.com/web/p/programmable-logic-development-kits/6973456/}{RS 697-3456 }' ],
	[ 'Binder 6 contacts', '2', 'JTAG for DIF firmware upgrade', '\href{http://www.binder-connector.com/pdfsheets/download/en/09+0123+80+06}{Binder 09-0123-80-06}' ],
		[ 'Binder 6 contacts (plug)', '1', 'to DIF', '\href{https://www.binder-connector.de/pdfsheets/download/en/99+5122+00+06}{Binder 99-5122-00-06}' ],	
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'dif-firmware.tex',
      maincaption => 'Cables and connectors for the DIF firware update',
      label       => 'table:dif-firmware',
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
