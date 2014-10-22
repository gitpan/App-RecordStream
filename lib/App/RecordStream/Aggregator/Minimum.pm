package App::RecordStream::Aggregator::Minimum;

our $VERSION = "3.4";

use strict;
use lib;

use App::RecordStream::Aggregator::InjectInto::Field;
use base qw(App::RecordStream::Aggregator::InjectInto::Field);

sub new
{
   my $class = shift;
   my @args  = @_;

   return $class->SUPER::new(@args);
}

sub combine_field
{
   my $this   = shift;
   my $cookie = shift;
   my $value  = shift;

   return $value unless ( defined $cookie );

   if ( $cookie > $value )
   {
      return $value;
   }

   return $cookie;
}

sub short_usage
{
   return "minimum value for a field";
}

sub long_usage
{
   print "Usage: min,<field>\n";
   print "   Minimum value of specified field.\n";
   exit 1;
}

App::RecordStream::Aggregator::register_aggregator('minimum', __PACKAGE__);
App::RecordStream::Aggregator::register_aggregator('min', __PACKAGE__);

1;
