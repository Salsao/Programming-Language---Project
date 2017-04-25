package Cliente; 		

use strict;
use warnings;

# construtor		
sub new{	
	my $class = shift; 	
	my $self = {};		
	$self->{NOME} = undef;
	$self->{ENDERECO} = undef;
	$self->{TELEFONE} = undef;
	$self->{REFERENCIA} = undef;	

	bless($self, $class);

	return $self;
}

# encapsulamento dos atributos
sub nome{
	my $self = shift;
	$self->{NOME} = shift if @_;
	return $self->{NOME};
}

sub endereco{
	my $self = shift;
	$self->{ENDERECO} = shift if @_;
	return $self->{ENDERECO};
}

sub telefone{
	my $self = shift;
	$self->{TELEFONE} = shift if @_;
	return $self->{TELEFONE};
}

sub referencia{
	my $self = shift;
	$self->{REFERENCIA} = shift if @_;
	return $self->{REFERENCIA};
}


# metodos



1;
