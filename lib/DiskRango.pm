package DiskRango; 		

use strict;
use warnings;

# construtor
sub new{		
	my $class = shift; 	
	my $self = {
		entregadores;
		
		
		
	};		
	
	bless($self, $class);

	return $self;
}

# encapsulamento dos atributos
sub entregadores{
	my $self = shift;
	$self->{$entregadores} = shift if @_;
	return $self->{NOME};
}

sub preco{
	my $self = shift;
	$self->{PRECO} = shift if @_;
	return $self->{PRECO};
}

# metodos

1;