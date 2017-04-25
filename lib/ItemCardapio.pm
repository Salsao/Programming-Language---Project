package ItemCardapio; 		

use strict;
use warnings;

# construtor
sub new{		
	my $class = shift; 	
	my $self = {};
	$self->{ID} = undef;		
	$self->{NOME} = undef;
	$self->{PRECO} = undef;	

	bless($self, $class);

	return $self;
}

# encapsulamento dos atributos
sub id{
	my $self = shift;
	$self->{ID} = shift if @_;
	return $self->{ID};
}

sub nome{
	my $self = shift;
	$self->{NOME} = shift if @_;
	return $self->{NOME};
}

sub preco{
	my $self = shift;
	$self->{PRECO} = shift if @_;
	return $self->{PRECO};
}

# metodos

1;
