% BibTeX standard bibliography style `unsrt'
	% version 0.98c for BibTeX versions 0.98i or later, LaTeX version 2.08
	% Copyright (C) 1985, all rights reserved
	% Copying of this file is authorized only if either
	% (1) you make absolutely no changes to your copy, including name, or
	% (2) if you do make changes, you name it something other than
	% btxbst.doc, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst
	% This restriction helps ensure that all standard styles are identical
%
% Modified by W. Entenmann, Feb. 21, 1997
% for "ACUSTICA - acta acustica"  (neuer Zitierstil ab 1997)
% Letzte Aenderung: 13.11.1997.

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  {label}

INTEGERS { output.state before.all mid.sentence after.sentence after.block
 after.colon after.blank after.in after.dash }

FUNCTION {init.state.consts}
{  #0 'before.all :=
   #1 'mid.sentence :=
   #2 'after.sentence :=
   #3 'after.block :=
   #4 'after.colon :=
   #5 'after.blank :=
   #6 'after.in :=
   #7 'after.dash :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state after.dash =
    { add.period$ "~-- " * write$ }
    { output.state after.in =
        { add.period$ "~-- In: " * write$ }
        { output.state after.blank =
            { " " * write$ }
            { output.state after.colon =
                { ": " * write$ }
                { output.state mid.sentence =
                    { ", " * write$ }
                    { output.state after.block =
        	        { add.period$ write$
	                  newline$
	                  "\newblock " write$
         	        }
	                { output.state before.all =
	                    'write$
	                    { add.period$ " " * write$ }
	                  if$
	                }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
   mid.sentence 'output.state :=
  s
}



FUNCTION {output}
{  duplicate$ empty$
     'pop$
     'output.nonnull
   if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
   before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    {  after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
	'skip$
	{  after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {new.colon}
{ output.state before.all =
    'skip$
    {  after.colon 'output.state := }
  if$
}

FUNCTION {new.blank}
{ output.state before.all =
    'skip$
    {  after.blank 'output.state := }
  if$
}

FUNCTION {new.in}
{ output.state before.all =
   'skip$
   {  after.in 'output.state := }
 if$
}

FUNCTION {new.dash}
{ output.state before.all =
    'skip$
    {  after.dash 'output.state := }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka }
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb }
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka }
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb }
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {italicize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\itshape " swap$ * "}" * }
  if$
}

FUNCTION {boldface}
{  duplicate$ empty$
    { pop$ "" }
    { "{\bfseries " swap$ * "}" * }
  if$
}

FUNCTION {paranteses}
{  duplicate$ empty$
    { pop$ "" }
    { "(" swap$  * ")" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{  's :=
   #1 'nameptr :=
   s num.names$ 'numnames :=
   numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f. }{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
            { ", " * t * }
	    { numnames #2 >
		{  "" *  }
		'skip$
	      if$
	      t "others" =
		{  " et~al." * }
		{  ", " * t *  }
	      if$
	    }
	  if$
	}
	't
      if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.names.mod}
{  's :=
   ""
   s num.names$ 'numnames :=
   #1 'nameptr :=
   s nameptr "{f. }{vv~}{ll}{, jj}" format.name$  't :=
   t  *
   numnames #1 >
      {  " et~al." *  }
      'skip$
    if$
}



FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor num.names$ #1 >
	{ editor format.names " (eds.)" * }
	{ editor format.names " (ed.)" * }
      if$
    }
  if$
}

FUNCTION {format.editors.mod}
{ editor empty$
    { "" }
    { editor "" =
        { "" }
        { "Hrsg.: " editor format.names.mod * }
      if$
    }
  if$
}


FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {n.dashify}
{  't :=
   ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
	{ t #1 #2 substring$ "--" = not
	    {  "--" *
	       t #2 global.max$ substring$ 't :=
	    }
	    {   { t #1 #1 substring$ "-" = }
		{  "-" *
		   t #2 global.max$ substring$ 't :=
		}
	      while$
	    }
	  if$
	}
	{  t #1 #1 substring$ *
	   t #2 global.max$ substring$ 't :=
	}
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
	{ "" }
	{ "there's a month but no year in " cite$ * warning$
	  month
	}
      if$
    }
    { month empty$
	'year
	{ month " " * year * }
      if$
    }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
       series empty$
         'skip$
         { " of " * series emphasize * }
       if$
       "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.number}
{ number empty$
    { "" }
    { "Nr.~" number * }
  if$
}

FUNCTION {format.volume}
{ volume empty$
    { "" }
    { "Vol.~" volume * }
  if$
}

FUNCTION {format.chapter}
{ chapter empty$
    { "" }
    { "Kap.~" chapter * }
  if$
}


FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " ed." * }
        { edition "t" change.case$ " ed." * }
      if$
    }
  if$
}

INTEGERS {multiresult}

FUNCTION {multi.page.check}
{  't :=
   #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
	{  #1 'multiresult := }
	{  t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        {  pages n.dashify }
        {  pages }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ":" * pages n.dashify * }
      if$
    }
  if$
}


FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "Ch." }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
	'skip$
	{ ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.tr}
{ type empty$
    { "Tech. Rept. " }
    { type }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
     { "" }
     { editor empty$
         { "In: "  booktitle * }
         { "In: " booktitle * ", " * format.editors * }
       if$
     }
   if$
 }

 FUNCTION {empty.misc.check}
 { author empty$ title empty$ howpublished empty$
   month empty$ year empty$ note empty$
   and and and and and
     { "all relevant fields are empty in " cite$ * warning$ }
     'skip$
   if$
 }

 FUNCTION {format.thesis.type}
 { type empty$
     'skip$
     { pop$
       type "t" change.case$
     }
   if$
 }

 FUNCTION {format.tr.number}
 { type empty$
     { "Tech. Rept." }
     'type
   if$
  number empty$
     { "t" change.case$ }
     { number tie.or.space.connect }
   if$
 }

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { "--In: " journal *  }
      if$
    }
    { "--In: " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{f. }{vv~}{ll}{, jj}" format.name$
  editor num.names$  #1 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In: "
    }
    { "Vol. " volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
     { key empty$
         { series empty$
             { "need editor, key, or series for " cite$ * " to crossref " *
               crossref * warning$
               "" *
             }
             { series * }
           if$
         }
         { key * }
       if$
     }
     { format.crossref.editor * }
   if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
     { key empty$
         { booktitle empty$
             { "need editor, key, or booktitle for " cite$ * " to crossref " *
                crossref warning$
                ""
             }
             { "In: " booktitle * }
           if$
         }
         { "In: " key * }
       if$
     }
     { "In: " format.crossref.editor * }
   if$
   " \cite{" crossref * "}" *
 }



FUNCTION {article}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title"  output.check
  new.block
  crossref missing$
  { journal "journal" output.check
  new.blank
  volume boldface output
  new.blank
   format.date paranteses "year" output.check
  new.blank
   format.pages output
  }
  { format.article.crossref output.nonnull
  format.pages output
  }
if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    {  format.editors "author and editor" output.check }
    {  format.authors output.nonnull
       crossref missing$
           { "author and editor" editor either.or.check }
           'skip$
         if$
    }
  if$
  new.colon
   format.title "title" output.check
  new.block
  format.volume output
  new.block
  format.edition output
  new.block
   publisher field.or.null "publisher" output.check
  address field.or.null output
   format.date "year" output.check
  series field.or.null paranteses output
  format.pages output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.colon
   format.title "title" output.check
  new.block
  howpublished field.or.null output
  address field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author missing$
    {  format.editors "author and editor" output.check }
    {  format.authors "author" output.check }
  if$
  new.colon
   format.title "title" output.check
  new.block
  format.volume output
  new.block
  format.edition output
  new.block
   publisher field.or.null "publisher" output.check
  address field.or.null output
   format.date "year" output.check
   format.chapter.pages "chapter and pages" output.check
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
   format.authors "authors" output.check
  new.colon
   format.title "title" output.check
  new.in
   booktitle field.or.null "booktitle" output.check
  new.block
  format.editors output
  new.block
   publisher field.or.null "publisher" output.check
     address field.or.null output
   format.date "year" output.check
  format.chapter output
  format.pages output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title" output.check
  new.block
   booktitle field.or.null "booktitle" output.check
  address field.or.null output
   format.date "year" output.check
  format.editors output
  organization field.or.null output
  publisher field.or.null output
  format.pages output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.authors output
  new.colon
   format.title "title" output.check
  new.block
  format.edition output
  new.block
  organization field.or.null output
  address field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title" output.check
  new.block
  "Diploma Thesis" output
  new.block
   school field.or.null "school" output.check
  address field.or.null output
   format.date "year" output.check
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  new.colon
  format.title output
  new.block
  howpublished field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title" output.check
  new.block
  "Dissertation" output
  new.block
   school field.or.null "school" output.check
  address field.or.null output
   format.date "year" output.check
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor missing$
    { organization missing$
	'skip$
	{ organization field.or.null output }
      if$
    }
    { format.editors output }
  if$
  new.colon
   format.title "title" output.check
  new.block
  editor missing$
    'skip$
    { organization field.or.null output }
  if$
  new.block
  publisher field.or.null output
  address field.or.null output
   format.date "year" output.check
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title" output.check
  new.block
  format.tr output
  new.blank
  number field.or.null output
   institution field.or.null "institution" output.check
  address field.or.null output
   format.date "year" output.check
  new.block
  note field.or.null output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
   format.authors "author" output.check
  new.colon
   format.title "title" output.check
  new.block
  format.date output
  new.block
   note field.or.null "note" output.check
  fin.entry
}

FUNCTION {default.type} { book }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"M\newumlaut arz"}

MACRO {apr} {"Apr."}

MACRO {may} {"Mai"}

MACRO {jun} {"Juni"}

MACRO {jul} {"Juli"}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sep."}

MACRO {oct} {"Okt."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dez."}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

MACRO {aeu} {"Arch. Elektron. \newumlaut Uebertr.tech."}


READ

STRINGS {longest.label}

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{  "" 'longest.label :=
   #1  'number.label :=
   #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{  number.label int.to.str$ 'label :=
   number.label #1 + 'number.label :=
  label width$ longest.label.width >
    {  label 'longest.label :=
       label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$}
  if$
  "\begin{thebibliography}{"  longest.label  *
"}" *
write$
  newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {finish.up} { newline$ "\end{thebibliography}" write$ newline$ }

EXECUTE {finish.up}
