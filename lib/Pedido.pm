package Pedido; 		

use strict;
use warnings;

# construtor		
sub new{	
	my $class = shift; 	
	my $self = {};		
	$self->{NOME} = undef;
	$self->{TELEFONE} = undef;
	$self->{DATA} = undef;
	$self->{HORA} = undef;	
	$self->{TOTAL} = undef;

	bless($self, $class);

	return $self;
}

# encapsulamento dos atributos
sub nome{
	my $self = shift;
	$self->{NOME} = shift if @_;
	return $self->{NOME};
}

sub telefone{
	my $self = shift;
	$self->{TELEFONE} = shift if @_;
	return $self->{TELEFONE};
}

sub data{
	my $self = shift;
	$self->{DATA} = shift if @_;
	return $self->{DATA};
}

sub hora{
	my $self = shift;
	$self->{HORA} = shift if @_;
	return $self->{HORA};
}

sub total{
	my $self = shift;
	$self->{TOTAL} = shift if @_;
	return $self->{TOTAL};
}


# metodos



1;
