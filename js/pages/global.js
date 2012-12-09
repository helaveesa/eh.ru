// Custom Apps breadcrumb
var breadcrumbString = $('#breadcrumbs').html().replace(/^\s\s*/gm, '').replace(/\s\s*$/gm, '');
if (breadcrumbString === '<h1>Apps</h1>') {
    $('#breadcrumbs').html('<a href="/WhatWeOffer">What We Offer</a> / <h1>App Ecosystem</h1>');
}
if ($('body').hasClass('app-family')) {
    //console.log(breadcrumbString);
    var newBreadCrumb = breadcrumbString.replace('<a href="/WhatWeOffer/AppEcosystem ">Apps</a>', '<a href="/WhatWeOffer">What We Offer</a> / <a href="/WhatWeOffer/AppEcosystem">App Ecosystem</a>');
    $('#breadcrumbs').html(newBreadCrumb);
}
else if ($('body').hasClass('app')) {
    var breadbits = breadcrumbString.split('\n');
    if (breadbits[6] === '<h1>Overview</h1>') {
        var newBreadCrumb = breadbits[0] + " / " + breadbits[2] + " / <h1>" + breadbits[4] + "</h1>";
        $('#breadcrumbs').html(newBreadCrumb);
    }
}

$(document).ready(function () {
    // Register main navigation events
    $('#nav-main a').mouseover(function () {
        $('body > nav').fadeIn().attr('class', $(this).attr('class'));
    }).mouseout(function () {
        //$('body > nav').fadeOut();
    });

    // Register form events
    $('form').on('focus', 'input[type="text"], textarea', function (e) {
        $(this).parent().siblings('.control-label').show().addClass('right').addClass('focus');
    }).on('blur', 'input[type="text"], textarea', function () {
        $(this).parent().siblings('.control-label').removeClass('focus');
        if ($(this).val() === '')
            $(this).parent().siblings('.control-label').removeClass('right');
        else
            $(this).parent().siblings('.control-label').hide();
    });

    $('input[type="text"], textarea').each(function () {
        if ($(this).val() !== '')
            $(this).parent().siblings('.control-label').addClass('right').hide();
    });

    // Set up smart timestamps
    $('time.timeago').timeago();

    // Set up truncated text
    $('.dotdotdot').dotdotdot({

    });

    // Set up below-the-fold button if there is a banner
    if ($('section.feature').length > 0) {
        var btf_button = '<div id="btf"><a href="#"></a></div>';
        $('section.feature').append(btf_button);

        $('#btf').click(function(e) {
            e.preventDefault();
            _gaq.push(['_trackEvent', 'Scroll Below the Fold Button', 'Click']);
            $('html,body').animate({
                scrollTop: $('section.feature').next('section').offset().top
            }, 500);
        })
    }

    // Set up image fading rotation on all .image-rotate containers
    var rotatingImageSets = [];
    $('.image-rotate').each(function () {
        var item = $(this);
        setInterval(function () { rotateImagesInContainer(item); }, 3000);
    });


    if ($('body').hasClass('were-hiring')) {
        $('#job-list > li > a').click(function (e) {
            var job = $(this).attr('data-job');
            if ($('#positions .right > div[data-job="' + job + '"]').hasClass('open')) return;

            $('#positions .right > div.open').removeClass('open').stop(false, false).slideUp(500);
            $('#positions .right > div[data-job="' + job + '"]').appendTo('#positions .right').addClass('open').slideDown(500);
        });
    }

    if ($('body').hasClass('customer-success')) {
        $('#wall a').mouseover(function () {
            $(this).parent().css('background-position', '0px -140px');
        }).mouseout(function () {
            $(this).parent().css('background-position', '0px 0px');
        });
    }
});

function rotateImagesInContainer(container)
{
    $('img:last-child', container).fadeOut(500, function () {
        $(this).prependTo($(container)).show();
    });
}
