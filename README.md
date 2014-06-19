# Example of the reverse pagination
[![Build Status](https://secure.travis-ci.org/Djo/reverse_will_paginate.png "Build Status")](http://travis-ci.org/Djo/reverse_will_paginate)

With the standard pagination strategy on adding a new content you will have situation when the older content moves from page #1 to page #2 and so on. It leads to issues with SEO, indexing and UX. This example shows you how to implement reverse pagination with [will_paginate](https://github.com/mislav/will_paginate) and floating limit for the first (index) page to avoid such issues.

## How it looks

For example you need to display 3 posts per page. In this case you will have from 3 to 5 posts on the start page:

9 posts will produce 3 pages with 3 posts on the index:

    9..7 posts on the /posts
    6..4 posts on the /posts/page-2
    3..1 posts on the /posts/page-1

10 posts will produce 3 pages with 4 posts on the index:

    10..7 posts on the /posts
    6..4  posts on the /posts/page-2
    3..1  posts on the /posts/page-1

11 posts will produce 3 pages with 5 posts on the index:

    11..7 posts on the /posts
    6..4  posts on the /posts/page-2
    3..1  posts on the /posts/page-1

And posts will produce 4 pages with 3 posts on the index:

    12..10 posts on the /posts
    9..7   posts on the /posts/page-3
    6..4   posts on the /posts/page-2
    3..1   posts on the /posts/page-1

## How it works

To get this behaviour you need to implement the floating limit for the first page.

I didn't find better solution with will_paginate than to convert a given relation to collection to set the right limit for the start page.<br />See [specs](https://github.com/Djo/reverse_will_paginate/tree/master/spec/controllers/cities_controller_spec.rb).

Also look at [https://github.com/Djo/reverse_kaminari](https://github.com/Djo/reverse_kaminari).
