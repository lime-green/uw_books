### UW Books
----

#### Overview
Base URL: `uw-books.herokuapp.com/api/v1`

There are currently 4 endpoints:
* `/books`
* `/courses`
* `/books/:department/:number`
* `/courses/:department/:number`

#### Usage

Some simple usage examples are shown below.

**Notes**:

`reqopt` describes whether the specified book is required.

`sku` is BookLook’s internal stock-keeping unit.
It is equivalent to a book’s ISBN, except for special non-books such as “NO TEXT” and Media-Doc course texts.
In these cases, the `sku` contains an alphabet character, so it is easy to distinguish real books from non-published ones.

##### /books/:department/:number
----
Optional parameters: `term`, `section`, `page`

Example queries:
* `uw-books.herokuapp.com/api/v1/books/econ/202`
* `uw-books.herokuapp.com/api/v1/books/econ/202?term=1149&section=001`

Example output:
```
{
  "meta": {
    "current_page": 1,
    "next_page": null,
    "total_pages": 1,
    "total_entries": 3,
    "per_page": 40
  },
  "books": [
    {
      "author": "MANKIW & SCARTH",
      "title": "MACROECONOMICS 5TH CDN ED",
      "sku": "9781464168505",
      "price": 137.5,
      "stock": 26,
      "reqopt": true,
      "courses": [
        {
          "department": "ECON",
          "number": "202",
          "section": "001",
          "instructor": "Vaughan,Maryann",
          "term": "1149"
        }
      ]
    },
    {
      "author": "MANKIW & SCARTH",
      "title": "MACROECONOMICS 5TH CDN ED W/ STUDY GUIDE PKG",
      "sku": "9781319000189",
      "price": 143.75,
      "stock": 95,
      "reqopt": false,
      "courses": [
        {
          "department": "ECON",
          "number": "202",
          "section": "001",
          "instructor": "Vaughan,Maryann",
          "term": "1149"
        }
      ]
    },
    {
      "author": "MANKIW & SCARTH",
      "title": "STUDY GUIDE FOR MACROECONOMICS 5TH CDN ED",
      "sku": "9781464175329",
      "price": 38.15,
      "stock": 38,
      "reqopt": false,
      "courses": [
        {
          "department": "ECON",
          "number": "202",
          "section": "001",
          "instructor": "Vaughan,Maryann",
          "term": "1149"
        }
      ]
    }
  ]
}
```

##### /courses/:department/:number
----
Optional parameters: `term`, `section`, `page`

Example queries:
* `uw-books.herokuapp.com/api/v1/courses/econ/202`
* `uw-books.herokuapp.com/api/v1/courses/econ/202?term=1149&section=001`

Example output:
```
{
  "meta": {
    "current_page": 1,
    "next_page": null,
    "total_pages": 1,
    "total_entries": 1,
    "per_page": 40
  },
  "courses": [
    {
      "department": "ECON",
      "number": "202",
      "section": "001",
      "instructor": "Vaughan,Maryann",
      "term": "1149",
      "books": [
        {
          "author": "MANKIW & SCARTH",
          "title": "MACROECONOMICS 5TH CDN ED",
          "sku": "9781464168505",
          "price": 137.5,
          "stock": 26,
          "reqopt": true
        },
        {
          "author": "MANKIW & SCARTH",
          "title": "MACROECONOMICS 5TH CDN ED W/ STUDY GUIDE PKG",
          "sku": "9781319000189",
          "price": 143.75,
          "stock": 95,
          "reqopt": false
        },
        {
          "author": "MANKIW & SCARTH",
          "title": "STUDY GUIDE FOR MACROECONOMICS 5TH CDN ED",
          "sku": "9781464175329",
          "price": 38.15,
          "stock": 38,
          "reqopt": false
        }
      ]
    }
  ]
}
```

##### /books
----
Optional parameters: `term`, `page`

Example queries:
* `uw-books.herokuapp.com/api/v1/books`
* `uw-books.herokuapp.com/api/v1/books?term=1149&page=1`

Example output:
```
{
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "total_pages": 40,
    "total_entries": 1577,
    "per_page": 40
  },
  "books": [
    {
      "author": "SHREVE S E",
      "title": "STOCHASTIC CALCULUS FOR FINANCE 1",
      "sku": "9780387249681",
      "price": 62.0,
      "stock": 0,
      "reqopt": true,
      "courses": [
        {
          "department": "ACC",
          "number": "770",
          "section": "001",
          "instructor": "Li,Bin",
          "term": "1149"
        },
        {
          "department": "ACTSC",
          "number": "970",
          "section": "001",
          "instructor": "Li,Bin",
          "term": "1149"
        }
      ]
    },
    {
      "author": "SHREVE",
      "title": "STOCHASTIC CALCULUS FOR FINANCE II",
      "sku": "9780387401010",
      "price": 88.0,
      "stock": 0,
      "reqopt": true,
      "courses": [
        {
          "department": "ACC",
          "number": "770",
          "section": "001",
          "instructor": "Li,Bin",
          "term": "1149"
        }
      ]
    },
...
```

##### /courses
----
Optional parameters: `term`, `page`

Example queries:
* `uw-books.herokuapp.com/api/v1/courses`
* `uw-books.herokuapp.com/api/v1/courses?term=1149&page=1`

Example output:
```
{
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "total_pages": 44,
    "total_entries": 1759,
    "per_page": 40
  },
  "courses": [
    {
      "department": "ACC",
      "number": "770",
      "section": "001",
      "instructor": "Li,Bin",
      "term": "1149",
      "books": [
        {
          "author": "SHREVE S E",
          "title": "STOCHASTIC CALCULUS FOR FINANCE 1",
          "sku": "9780387249681",
          "price": 62.0,
          "stock": 0,
          "reqopt": true
        },
        {
          "author": "SHREVE",
          "title": "STOCHASTIC CALCULUS FOR FINANCE II",
          "sku": "9780387401010",
          "price": 88.0,
          "stock": 0,
          "reqopt": true
        }
      ]
    },
    {
      "department": "ACC",
      "number": "781",
      "section": "001",
      "instructor": "O'Brien,Patricia",
      "term": "1149",
      "books": [
        {
          "author": "LIPSON",
          "title": "DOING HONEST WORK IN COLLEGE 2ND ED",
          "sku": "9780226484778",
          "price": 16.1,
          "stock": 0,
          "reqopt": true
        },
        {
          "author": "SHADISH ET AL",
          "title": "EXPERIMENTAL & QUASI-EXPERIMENTAL DESIGNS 2ED",
          "sku": "9780395615560",
          "price": 177.95,
          "stock": 0,
          "reqopt": true
        },
        {
          "author": "TROCHIM & DONNELLY",
          "title": "RESEARCH METHODS KNOWLEDGE BASE 3ED",
          "sku": "9781592602919",
          "price": 162.95,
          "stock": 0,
          "reqopt": false
        }
      ]
    },
...
```
