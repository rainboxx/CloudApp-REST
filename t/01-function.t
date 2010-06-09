#!perl

use strict;
use warnings;

use Test::More tests => 7;

use_ok('CloudApp::REST');

my $cl = CloudApp::REST->new;
isa_ok($cl, "CloudApp::REST");    # Really ;-)

SKIP: {

    # Skip these tests if no user data is set
    skip "Set \$ENV{CL_USER} and \$ENV{CL_PASS} (and \$ENV{CL_PROXY}) for live test", 5 unless $ENV{CL_USER} || $ENV{CL_PASS};

    # Optional: proxy
    if ($ENV{CL_PROXY}) {
        $cl->proxy($ENV{CL_PROXY});
    }

    is($cl->username($ENV{CL_USER}), $ENV{CL_USER}, 'Setting username/e-mail');
    is($cl->password($ENV{CL_PASS}), $ENV{CL_PASS}, 'Setting password');

    diag "Will send a request, this may take a while.";

    my $items;
    eval { $items = $cl->get_items({ per_page => 2, page => 1 }); };
    if ($@) {
        fail("Loading items from CloudApp: $@");
    } else {
        pass("Loading items from CloudApp");
    }

    cmp_ok(scalar @$items, '<=', 2, "Got maximum 2 items (got exactly " . scalar @$items . ")");

  SKIP: {
        skip "No items within your account, cannot proceed tests", 1 unless @$items;

        diag "Will send a request, this may take a while.";

        # Get the item again as single item
        my $first_item = $items->[0];
        my $item = $cl->get_item({ slug => $first_item->slug });

        # Should be totally equal
        is_deeply($item, $first_item, "Items from get_items and get_item are equal");
    }

    # We don't test anything more, because the previous tests show
    # if the workflow works or not.
}
