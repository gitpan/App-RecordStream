package App::RecordStream::Aggregator::MapReduce::Field;

our $VERSION = "3.4";

use strict;
use lib;

use App::RecordStream::Aggregator::MapReduce;

use base 'App::RecordStream::Aggregator::MapReduce';

sub new
{
   my $class = shift;
   my ($field) = @_;

   my $this =
   {
      'field' => $field,
   };
   bless $this, $class;

   return $this;
}

sub map
{
   my ($this, $record) = @_;

   if(!defined($this->{'field'}))
   {
       # oopsie, consider missing/undef fields not to count and return the empty cookie
       return undef;
   }
   return $this->map_field(${$record->guess_key_from_spec($this->{'field'})});
}

sub map_field
{
   my ($this, $value) = @_;

   return $value;
}

sub argct
{
   return 1;
}

1;
