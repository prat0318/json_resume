var currPage = 1; //Pages are 1-based not 0-based
var numPages = 0;
var thePDF1 = null;
var thePDF2 = null;

//This is where you start
PDFJS.getDocument("resume_default.pdf").then(function(pdf) {

        //Set PDFJS global object (so we can easily access in our page functions
        thePDF1 = pdf;

        //How many pages it has
        numPages = pdf.numPages;

        //Start with first page
        pdf.getPage( 1 ).then( handlePages );
});

PDFJS.getDocument("resume_classic.pdf").then(function(pdf) {

        //Set PDFJS global object (so we can easily access in our page functions
        thePDF2 = pdf;

        //How many pages it has
        numPages = pdf.numPages;

        //Start with first page
        pdf.getPage( 1 ).then( handlePages1 );
});


function handlePages(page)
{
    //This gives us the page's dimensions at full scale
  if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
    var viewport = page.getViewport( 0.8 );
  } else {
    var viewport = page.getViewport( 1.2 );
  }
    

    //We'll create a canvas for each page to draw it on
    var canvas = document.createElement( "canvas" );
    canvas.style.display = "block";
    var context = canvas.getContext('2d');
    canvas.height = viewport.height;
    canvas.width = viewport.width;

    //Draw it on the canvas
    page.render({canvasContext: context, viewport: viewport});

    //Add it to the web page
    document.getElementById('the-canvas').appendChild( canvas );

    //Move to next page
    currPage++;
    if ( thePDF1 !== null && currPage <= numPages )
    {
        thePDF1.getPage( currPage ).then( handlePages );
    }
}

function handlePages1(page)
{
    //This gives us the page's dimensions at full scale
  if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
    var viewport = page.getViewport( 0.8 );
  } else {
    var viewport = page.getViewport( 1.2 );
  }
    

    //We'll create a canvas for each page to draw it on
    var canvas = document.createElement( "canvas" );
    canvas.style.display = "block";
    var context = canvas.getContext('2d');
    canvas.height = viewport.height;
    canvas.width = viewport.width;

    //Draw it on the canvas
    page.render({canvasContext: context, viewport: viewport});

    //Add it to the web page
    document.getElementById('the-canvas1').appendChild( canvas );

    //Move to next page
    currPage++;
    if ( thePDF2 !== null && currPage <= numPages )
    {
        thePDF2.getPage( currPage ).then( handlePages1 );
    }
}
