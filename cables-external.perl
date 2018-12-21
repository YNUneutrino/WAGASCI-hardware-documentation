#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Purpose', 'Cables/Connectors', '\#', 'Remarks', 'Reference' ],
];
 
my $data = [
	[ '\textbf{DIF data}', '?cm HDMI', '2', 'to GDCC', 'Any cable is good' ],
	[ '\textbf{IF LV}', 'Binder 5 contacts (plug)', '2', 'to LV', '\href{https://www.binder-connector.de/pdfsheets/download/en/99+5114+00+05}{Binder 99-5114-00-05}' ],
	[ '', 'Crimping terminals', '4', 'to LV PSU', '\href{https://jp.rs-online.com/web/p/crimp-ring-terminals/6048389/}{RS 604-8389}' ],
	[ '\textbf{DIF firmware}', 'Binder 6 contacts (plug)', '2', 'to DIF', '\href{https://www.binder-connector.de/pdfsheets/download/en/99+5122+00+06}{Binder 99-5122-00-06}' ],
	[ '', 'JTAG cable\'s wires', '2', 'to XILINX', '\href{https://lappjapan.lappgroup.com/fileadmin/documents/technische_doku/datenblaetter/unitronic/DB0034302EN.pdf}{0034302}' ],
	[ '\textbf{LED}', 'Binder 14 contacts (plug)', '2', 'to LED', '\href{https://www.binder-connector.de/pdfsheets/download/en/99+5452+00+14}{Binder 99-5452-00-14}' ],
	[ '\textbf{IF HV}', 'SHV connector female', '2', 'to HV', '\href{https://jp.rs-online.com/web/p/shv-connectors/2127438/}{RS 212-7438}' ],
	[ '', 'BNC 50$\Omega$', '2', 'to HV PSU', '\href{https://jp.rs-online.com/web/p/bnc-connectors/5464853}{RS 546-4853}' ],
	[ '', 'Coaxial Cable', '2', '50 $\Omega$', '\href{https://jp.rs-online.com/web/p/coaxial-cable/2228610/}{RS 222-8610}' ],
	[ '', 'DSUB connector', '2', 'to HV PSU', '???' ],
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'cables-external.tex',
      maincaption => 'Cables and connectors for outside the housing',
      label       => 'table:cables-external',
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
