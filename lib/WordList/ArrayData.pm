package WordList::ArrayData;

use strict;
use parent qw(WordList);

use Role::Tiny::With;
with 'WordListRole::EachFromFirstNextReset';

# AUTHORITY
# DATE
# DIST
# VERSION

our $DYNAMIC = 1;

our %PARAMS = (
    arraydata => {
        summary => 'ArrayData module name with optional args, e.g. "Number::Prime::First1000", "DBI=dsn,DBI:SQLite:dbname=/path/to/foo"',
        schema => 'perl::arraydata::modname_with_optional_args',
        req => 1,
    },
);

sub new {
    require Module::Load::Util;

    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->{_arraydata} = Module::Load::Util::instantiate_class_with_optional_args($self->{arraydata});
    $self;
}

sub reset_iterator {
    my $self = shift;
    $self->{_arraydata}->reset_iterator;
}

sub first_word {
    my $self = shift;
    $self->{_arraydata}->get_next_item;
}

sub next_word {
    my $self = shift;
    $self->{_arraydata}->get_next_item;
}

1;
# ABSTRACT: Wordlist from any ArrayData::* module

=head1 SYNOPSIS

From Perl:

 use WordList::ArrayData;

 my $wl = WordList::ArrayData->new(arraydata => 'Number::Prime::First1000');
 $wl->each_word(sub { ... });

From the command-line:

 % wordlist -w ArrayData=arraydata,Number::Prime::First1000


=head1 DESCRIPTION

This is a dynamic, parameterized wordlist to get list of words from an
ArrayData::* module. This module is a bridge between WordList and ArrayData.


=head1 SEE ALSO

L<WordList>

L<ArrayData>
