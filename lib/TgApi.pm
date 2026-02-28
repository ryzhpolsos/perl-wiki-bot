package TgApi;

use utf8;
use strict;
use warnings;

use Exporter qw(import);
use HTTP::Tiny;
use JSON qw(decode_json);

our @EXPORT = qw(set_token call_method);

my $token = '';
my $http = HTTP::Tiny->new();

sub set_token {
    $token = $_[0];
}

sub call_method {
    my ($method_name, $payload) = @_;

    my $response = $http->post_form("https://api.telegram.org/bot$token/$method_name", $payload);

    if(!$response->{success}){
        (0, "$response->{reason}: $response->{content}");
    }else{
        (1, decode_json($response->{content}));
    }
}

1;
