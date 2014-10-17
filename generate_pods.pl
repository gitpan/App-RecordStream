#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename qw(basename);

$ENV{'PERL5LIB'} .= ':lib';

# Don't let the actual terminal size affect POD everytime we generate it.
# LINES isn't used by us, but is required for Term::ReadKey::GetTerminalSize()
# to use COLUMNS.
$ENV{'COLUMNS'} = 80;
$ENV{'LINES'}   = 50;

generate_pod($_) for grep { not /recs-operation/ } <bin/recs-*>;

sub generate_pod {
  my $script = shift;

  print "Generating pod documentation for $script\n";

  my $script_base = basename($script);

  my @help = `$script --help-all 2>/dev/null`;

  open(my $fh, '>', "doc/$script_base.pod") or die "Could not open doc/$script_base.pod: $!";

  print $fh <<HEADER;
=head1 NAME

$script_base

=head1 $script_base --help-all

HEADER

  foreach my $line (@help) {
    print  $fh " " . $line;
  }

  print $fh <<FOOTER;

=head1 See Also

=over

=item  L<RecordStream(3)> - Overview of the scripts and the system

=item  L<recs-examples(3)> - A set of simple recs examples

=item  L<recs-story(3)> - A humorous introduction to RecordStream

=item SCRIPT --help - every script has a --help option, like the output above

=back

FOOTER

  close $fh;
}
