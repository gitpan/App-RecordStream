use strict;
use warnings;
package App::RecordStream::Manual::Examples;

=head1 NAME

App::RecordStream::Manual::Examples - A set of simple recs examples 

=head1 DESCRIPTION

This file provides a couple of useful examples of recs chains and how each of
them break down.  This is meant as a learning tool for folks new recs that
would like to see some cool things you can do with RecordStream.  Another good
resource is L<App::RecordStream::Manual::Story>, also viewable by running C<recs
story>, which is a humorous story meant to get the newest users used to recs.

=head1 EXAMPLES

=head2 How many processes is each user on my system running?

  recs fromps | recs collate --key uid -a count | recs sort --key count=n | recs totable

Broken down this is:

=over

=item 1. recs fromps

First get the records of all the prcesses currently running

=item 2. recs collate --key uid -a count

Grouping by the C<uid> field, count how many records fall into the group
(stored in the C<count> field by default)

=item 3. recs sort --key count=n

Sort the resulting records by the C<count> field numerically (rather than
lexically)

=item 4. recs totable

Print the output in a nicely formatted plain text table

=back

=head2 How many processes for each user at each priority level?

  recs fromps | recs collate --key uid,priority -a count | recs toptable --x priority --y uid --v count

Broken down:

=over

=item 1. recs fromps

First get the records of all the prcesses currently running

=item 2. recs collate --key uid,priority -a count

Grouping by the uid and the priority field, count how many records fall into
the group

=item 3. recs toptable --x priority --y uid -v count

Create a 2 dimensional table (a I<p>ivot I<table>), across the top put the
priority values, down the side put the uid, in each cell put the value of the
count field for that priority/uid.

=back

=head2 Prep a report on number of modules logging to Xorg.log

What Xorg modules put information in my Xorg.log at startup, and what log level
are they logged at?  I need this in CSV format for importing into a spreadsheet
program.

  recs frommultire --re 'type,module=\((\S*)\) ([^:]+):' /var/log/Xorg.0.log \
    | recs collate --key type,module -a ct \
    | recs sort --key ct=n \
    | recs tocsv --header

=over

=item 1. recs frommultire --re 'type,module=\((\S*)\) ([^:]+):' /var/log/Xorg.0.log

Parse out the type and module from the Xorg log file.  That regex captures
non-whitespace inside a literal C<()> pair, then captures text after a space up
to the first C<:> (colon).

=item 2. recs collate --key type,module -a ct

Collate records into groups of type-modules, and count how many in each group
across all records

=item 3. recs sort --key ct=n

Sort by the count, numerically

=item 4. recs tocsv --header

Output a table in spreadsheet format (no ASCII art), delimited by commas

=back

=head1 SEE ALSO

=over

=item * See L<App::RecordStream> for an overview of the scripts and the system

=item * Run C<recs story> or see L<App::RecordStream::Manual::Story> for a humorous introduction to RecordStream

=back

=cut

1;
