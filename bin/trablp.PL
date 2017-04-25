use strict;
use warnings;
use 5.010;
use POSIX qw(strftime);

use lib '../lib';
use Cliente;
use ItemCardapio;
use Entregador;
use Pedido;


my @words;
my @clientes;
my @entregadores;
my @cardapio;
my @pedidos;
my $flag = 1;

die "Arquivos de entrada não especificados. Use: -e <entregadores> -c <cardapio>", "\n" unless @ARGV == 4;
my ($file1, $file2, $file3, $file4) = @ARGV;
open (my $fh1, '<', $file2) or die "Não foi possível processar os arquivos especificados: '$file2','$file4'\n  $!";
open (my $fh2, '<', $file4) or die "Não foi possível processar os arquivos especificados: '$file2','$file4'\n  $!";



sub verificarCadastro{
	#for que percorre a lista de clientes vendo se o telefone ja ta cadastrado
	my($tel,@cli) = @_;
	my $i;
	
	if ($#cli == -1){
		return 0;
	}
	else{
		for ($i = 0; $i <= $#cli; $i++){
			my $aux = $cli[$i]->telefone();
			if($aux == $tel){
				return 1;
				}
		}
		return 0;
	}

}

sub verificarCodigo{
	my($codigo2) = @_;
	for(my $i = 0; $i <= $#cardapio; $i++){
		#say $codigo2; say"buuuuuuuuuf";
		if( $cardapio[$i]->id() eq $codigo2){
			return 1;
			}
		}
	return 0;	
	
}

sub retornarNomeClientePorTelefone{
	my($tel,@cli) = @_;
	my $i;
	for ($i = 0; $i <= $#cli; $i++)
	{
		if($cli[$i]->telefone() == $tel)
		{
			return $cli[$i]->nome();
		}
	}
}


sub realizarCadastroRecadastro{
	my ($tel) = @_; 
	my $clienteNovo = Cliente->new();
	my $palavra;
	
	
	if (&verificarCadastro($tel,@clientes) == 0)
	{
		
		chomp $tel;
		$clienteNovo->{TELEFONE} = $tel;
		
		say "Cliente não cadastrado. Novo cadastro:\n\tNome:";
		$palavra = <STDIN>;
		chomp $palavra;
		$clienteNovo->{NOME} = $palavra;
		
		say "\tEndereço:";
		$palavra = <STDIN>;
		chomp $palavra;
		$clienteNovo->{ENDERECO} = $palavra;
		
		say "\tPonto de referência:";
		$palavra = <STDIN>;
		chomp $palavra;
		$clienteNovo->{REFERENCIA} = $palavra;
		
		$palavra = $clienteNovo->nome();
		say"Cliente Cadastrado: $palavra\n[C]onfirma ou [R]ecadastra?";
		$palavra = <STDIN>;
		
		chomp $palavra; #tiro o \n
		$palavra = uc $palavra; #coloco em caixa alta
		while( $palavra ne "C" ) #essa comparacao funciona no primeiro loop
		{
			say "entrou no while 1";
			$palavra = $clienteNovo->telefone();
			chomp $palavra;
			say "Recadastrando cliente (telefone $palavra):\n\tNome:\n";
			$palavra = <STDIN>;
			chomp $palavra;
			$clienteNovo->{NOME} = $palavra;
		
			say "\tEndereço:";
			$palavra = <STDIN>;
			chomp $palavra;
			$clienteNovo->{ENDERECO} = $palavra;
		
			say "\tPonto de referência:";
			$palavra = <STDIN>;
			chomp $palavra;
			$clienteNovo->{REFERENCIA} = $palavra;
			
			$palavra = $clienteNovo->nome();
			say"Cliente Cadastrado: $palavra\n[C]onfirma ou [R]ecadastra?";
			$palavra = <STDIN>;
			
			chomp $palavra; 
			$palavra = uc $palavra; 
			
		}
		push @clientes, $clienteNovo;
	}
	else{
			my $nomeClienteCadastrado = &retornarNomeClientePorTelefone($tel,@clientes);
			say "Cliente cadastrado: $nomeClienteCadastrado\n[C]onfirma ou [R]ecadastra?";
			$palavra = <STDIN>;
			
			chomp $palavra;
			$palavra = uc $palavra;
			if( $palavra ne "C" )
			{
				while( $palavra eq "R" )
				{

					my $count = 0;
					while ( $clientes[$count]->nome() ne &retornarNomeClientePorTelefone($tel,@clientes)){
						$count++;
					}
						
					$palavra = $clientes[$count]->telefone();
					say "Recadastrando cliente (telefone $palavra):\n\tNome:";
					$palavra = <STDIN>;
					chomp $palavra;
					$clientes[$count]->{NOME} = $palavra;
		
					say "\tEndereço:";
					$palavra = <STDIN>;
					chomp $palavra;
					$clientes[$count]->{ENDERECO} = $palavra;
		
					say "\tPonto de referência:";
					$palavra = <STDIN>;
					chomp $palavra;
					$clientes[$count]->{REFERENCIA} = $palavra;
					
					$palavra = $clientes[$count]->nome();
					say"Cliente Cadastrado: $palavra\n[C]onfirma ou [R]ecadastra?";
					$palavra = <STDIN>;
					
					chomp $palavra;
					$palavra = uc $palavra;		
				}
				#push @cli, $clienteNovo;
			}
		}
			
}

sub realizarPedido{
	
	my($tel,@clientes) = @_;

	my ($nomeProduto, $preco, $nomeCliente, $valorTotal);
	$valorTotal = 0;
	while(1){
		
		say"Adicionar item número (? para cardápio, 0 para finalizar):";
		#my $codigo; 
		my $codigo = <STDIN>;
		chomp $codigo;
	
		if ($codigo eq '0'){
			say "Total: R\$ $valorTotal. Confirma?";
			my $resposta = <STDIN>;
			$resposta = uc $resposta;
			chomp $resposta;
			if($resposta eq 'S'){
				my $date = strftime "%e/%m/%Y", localtime;
				my $hour = strftime "%R", localtime; 

				$nomeCliente = retornarNomeClientePorTelefone($tel,@clientes);
				my $pedidoNovo = Pedido->new();
				$pedidoNovo->{NOME} = $nomeCliente;
				$pedidoNovo->{TELEFONE} = $tel;
				$pedidoNovo->{DATA} = $date;
				$pedidoNovo->{HORA} = $hour;
				$pedidoNovo->{TOTAL} = $valorTotal;
				push @pedidos, $pedidoNovo;
				
			}return 0;
		}
		elsif ($codigo eq '?'){

			&imprimirCardapio(@cardapio);
		}
		elsif (&verificarCodigo($codigo) eq '1'){
			
			for(my $i=0; $i <= $#cardapio; $i++){
				my $aux = $cardapio[$i]->id();
				if($aux == $codigo){
					$nomeProduto = $cardapio[$i]->nome();
					$preco = $cardapio[$i]->preco();
				}
			}
			say "\tAdicionando \"$nomeProduto\" ao pedido. Quantidade: \n";
			my $qtd = <STDIN>;
			$preco = scalar $preco * $qtd;
			$valorTotal = $valorTotal + $preco;

			#crio um objeto pedido, seta td + nome e telefone e total, hora e data
			
		
		
		}else{
			say "\tNão há item com o código $codigo no cardápio.";
		}
		#exit(1);
	}
	
	
	
}

sub leituraEntregadores{ 
        my ($fh1, $flag, @words) = @_;
	while(<$fh1>){
		if ($flag){
		   $flag = 0;
		     }
		else {
			@words = split(';');
		       foreach my $word (@words){
			}
			#print "@words";
			my $entregador = Entregador->new();
			$entregador->{NOME} = $words[0];
			$entregador->{PLACA} = $words[1];
			push(@entregadores, $entregador);
		}
	}
close($fh1);
}

sub leituraCardapio{
	my ($fh2, $flag, @words) = @_;
	while (<$fh2>) {
	if ($flag){
	   $flag = 0;
	     }
	else {
       		@words = split(';');
       		foreach my $word (@words){}
		my $cardapio = ItemCardapio->new();
		$cardapio->{ID} = $words[0];
		$cardapio->{NOME} = $words[1];
		chomp $words[2];
		$words[2] =~ s/\,/./;
		$cardapio->{PRECO} = $words[2];
		push(@cardapio, $cardapio);
	}
}
close ($fh2);
}

sub imprimirCardapio{
	my @card = @_;
	my $j;
	for ($j =0; $j<=$#card; $j++){
		print "\t";
		print $card[$j]->id();
		print "\t";
		print"R\$ ";
		print $card[$j]->preco();
		print "\t";
		print $card[$j]->nome();
		print "\n";
	}
}

sub imprimirEntregadores{
	my @entreg = @_;
	my $j;
	for ($j =0; $j<=$#entreg; $j++){
		print "\t";
		print $entreg[$j]->nome();
		print "\t";
		print $entreg[$j]->placa();
		say "";

	}
}

sub imprimirClientes{
	my @cli = @_;
	my $j;
	for ($j =0; $j<=$#cli; $j++){
		print "\t";
		print $cli[$j]->nome();
		print "\t";
		print $cli[$j]->endereco();
		print "\t";
		print $cli[$j]->telefone();
		print "\t";
		print $cli[$j]->referencia();
		say"";
	}
}

sub gerarRelatorioPedido{
	my @ped = @_;
	my ($nome,$telefone,$data,$hora,$valorTotal);
	my $relatorio = "relatorioPedido.txt";
	open (my $fh, '>',$relatorio);
	say $fh "Nome;Telefone;Data;Hora;Valor total";
	for(my $i = 0; $i <= $#pedidos; $i++){
		$nome = $pedidos[$i]->nome();
		$telefone = $pedidos[$i]->telefone();
		$data = $pedidos[$i]->data();
		$hora = $pedidos[$i]->hora();
		$valorTotal = $pedidos[$i]->total();
		say $fh "$nome;$telefone;$data;$hora;R\$ $valorTotal";
	}

}



#####################################
# MAIN 
#####################################
say "DISQUE-RANGO\n";


	&leituraEntregadores($fh1, $flag, @words);
	$flag = 1;
	&leituraCardapio($fh2, $flag, @words);
	
while (1){
	
	say "Telefone (0 para sair):";
	my $telefone = <STDIN>;
	chomp $telefone;
	if( $telefone == 0){
		if(scalar @pedidos != 0){
			&gerarRelatorioPedido(@pedidos);
			exit(1);
		}else{
			exit(1);
		}
	}
	else{
		&realizarCadastroRecadastro($telefone);
		&realizarPedido($telefone, @clientes, @cardapio);
		
	#&imprimirEntregadores(@entregadores);	
	#&imprimirCardapio(@cardapio);
	#&imprimirClientes(@clientes);
	}
	#exit(1);
}
