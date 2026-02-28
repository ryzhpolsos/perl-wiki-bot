package WikiApi;

use utf8;
use strict;
use warnings;
use URI::Escape;

use Exporter qw(import);
use HTTP::Tiny;
use JSON qw(decode_json);

our @EXPORT = qw(get_summary);

my $http = HTTP::Tiny->new();

sub get_summary {
    my $page = $_[0];
    my $response = $http->get("https://ru.wikipedia.org/api/rest_v1/page/summary/". uri_escape_utf8($page) . "?redirect=false");
    my $data = decode_json($response->{content});

    { 'title' => $data->{title}, 'summary' => $data->{extract}, 'summary_html' => $data->{extract_html} };
}
