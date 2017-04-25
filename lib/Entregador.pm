package Entregador; 		

use strict;
use warnings;

# construtor		
sub new{	
	my $class = shift; 	
	my $self = {};		
	$self->{NOME} = undef;
	$self->{PLACA} = undef;	

	bless($self, $class);

	return $self;
}

# encapsulamento dos atributos
sub nome{
	my $self = shift;
	$self->{NOME} = shift if @_;
	return $self->{NOME};
}

sub placa{
	my $self = shift;
	$self->{PLACA} = shift if @_;
	return $self->{PLACA};
}

# metodos

1;