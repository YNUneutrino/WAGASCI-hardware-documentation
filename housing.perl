#!/usr/bin/perl
use LaTeX::Table;
use Number::Format qw(:subs);  # use mighty CPAN to format values
 
my $header = [
    [ 'Feedthrough connector', '\#', 'Remarks', 'Reference' ],
];
 
my $data = [
    [ 'HDMI', '2', 'GDCC-IF', '\href{https://jp.rs-online.com/web/p/hdmi-connectors/9093717/}{RS 909-3717}' ],
	[ 'SHV (Safe High Voltage)', '2', 'HV-IF', '\href{https://jp.rs-online.com/web/p/shv-connectors/2127444/}{RS 212-7444}' ],
	[ 'Binder 5 contacts', '2', 'LV-IF', '\href{https://www.binder-connector.de/pdfsheets/download/en/09+0115+80+05}{Binder 09-0115-80-05}' ],
	[ 'Binder 6 contacts', '2', 'JTAG for DIF firmware upgrade', '\href{http://www.binder-connector.com/pdfsheets/download/en/09+0123+80+06}{Binder 09-0123-80-06}' ],
	[ 'Binder 14 contacts', '2', 'For DIF LED', '\href{https://www.binder-connector.de/pdfsheets/download/en/09+0453+80+14}{Binder 09-0453-80-14}' ],
];
 
my $table = LaTeX::Table->new(
      {   
      filename    => 'housing.tex',
      maincaption => 'Housing feedthrough connectors',
      label       => 'table:housing',
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
