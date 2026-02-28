use utf8;
use v5.10.0;
use strict;
use warnings;

use FindBin;
use Dotenv -load;
use Data::Dumper;

use lib "$FindBin::Bin/lib";
use TgApi qw(set_token call_method);
use WikiApi qw(get_summary);

set_token($ENV{TOKEN});

my $last_update = 0;

while(1){
    my ($ok, $updates) = call_method('getUpdates', { 'offset' => $last_update });

    foreach my $update (@{$updates->{result}}){
        $last_update = $update->{update_id} + 1;

        if($update->{message}){
            my $text = $update->{message}->{text};

            if($text eq '/start'){
                call_method('sendMessage', { 'chat_id' => $update->{message}->{chat}->{id}, 'text' => 'Отправьте мне ФИО, и я пришлю краткую биографию человека.' });
            }else{
                my $response = get_summary($text);

                if($response->{summary}){
                    call_method('sendMessage', { 'chat_id' => $update->{message}->{chat}->{id}, 'text' => "<b><u>$response->{title}</u></b>\n\n$response->{summary}", 'parse_mode' => 'html' });
                }else{
                    call_method('sendMessage', { 'chat_id' => $update->{message}->{chat}->{id}, 'text' => 'Информация о человеке не найдена' });
                }
            }
        }
    }
}
