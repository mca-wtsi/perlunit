<?php
// (hacked from) Default Web Page for groups that haven't setup their page yet
// Please replace this file with your own website
//
// $Id: index.php,v 1.7 2005-11-27 15:41:13 mca1001 Exp $
//
$headers = getallheaders();
?>
<HTML>
<HEAD>
<TITLE>PerlUnit: unit testing framework for Perl</TITLE>
<LINK rel="stylesheet" href="http://sourceforge.net/sourceforge.css" type="text/css">
<base href="http://PerlUnit.sourceforge.net/"><!-- so I can test my local copy -->
</HEAD>

<BODY bgcolor=#FFFFFF topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" marginheight="0" marginwidth="0">

<!-- top title table -->
<TABLE width="100%" border=0 cellspacing=0 cellpadding=0 bgcolor="" valign="center">
  <TR valign="middle" bgcolor="#eeeef8">
    <TD>
      <!-- SF logo as requested in the SF docs -->
      <A href="http://sourceforge.net"><IMG src="http://sourceforge.net/sflogo.php?group_id=2653&type=1" width="88" height="31" border="0" alt="SourceForge Logo"></A>
    </TD>
    <td align="center"><h1>The &quot;PerlUnit&quot; unit testing framework</h1></td>
    <TD><!-- right of logo -->
      <a href="http://www.valinux.com"><IMG src="http://sourceforge.net/images/va-btn-small-light.png" align="right" alt="VA Linux Systems" border="0" width="105" height="31"></A>
    </TD><!-- right of logo -->
  </TR>
  <TR><TD bgcolor="#543a48" colspan="3"><IMG src="http://sourceforge.net/images/blank.gif" height="2" vspace="0"></TD></TR>
</TABLE>
<!-- end top title table -->



<p>If you don't know what a unit testing framework is or why you would
   want one, the <a href="#related">links</a> below will fill you in.
</p>

<p>If you want a unit testing framework for perl, the details are in
   the <a href="http://sourceforge.net/projects/perlunit/">project
   summary page</a>
   <a href="https://sourceforge.net/projects/perlunit/">(SSL)</a>.
   Here are some shortcuts to the important bits:
</p>

<ul>

<li>Grab the current release from our SourceForge download area [
    <a href="http://sourceforge.net/project/showfiles.php?group_id=2653">
    HTTP</a> | <a href="ftp://ftp.sourceforge.net/pub/sourceforge/perlunit/">FTP</a> ] or
    <a href="http://search.cpan.org/search?dist=Test-Unit">from CPAN</a>.

<p>
<li>We have two <a href="http://sourceforge.net/mail/?group_id=2653">mailing lists</a>,
    with archives:
    <ul>
    <li><a href="http://sourceforge.net/mailarchive/forum.php?forum_id=2442">
        perlunit-devel</a> (low volume discussion)
    <li><a href="http://sourceforge.net/mailarchive/forum.php?forum_id=2441">
        perlunit-users</a> (this list is quiet, if not silent)
    </ul>
    There are also some web-based forums but we've mostly abandoned
    them because we don't like the user interface.

<p>
<li>Browse the
    <a href="http://cvs.sourceforge.net/viewcvs.py/perlunit/">

    CVS repository</a> to see the current state of our files.  A quick
    outline of what's there:

  <dl>
   <dt>src/Test-Unit</dt>
   <dd>This is the source for the distributed package.</dd>

   <dt>src/Test-Unit-0.06, src/UnitTests, src/XUnit-0.01, src/api</dt>
   <dd>Old layouts of the project, everything is in the Attic.  Ignore.</dd>

   <dt>src/junit3.2</dt>
   <dt>src/tools</dt>
   <dd>This is project history - what Brian used to start the project.</dd>

   <dt>www/</dt>
   <dd>Contains the website
   <a href="http://perlunit.sourceforget.net/">http://perlunit.sourceforget.net/</a>,
   no released files or source.</dd>
  </dl>

</ul>

<p>Most of the documentation lives in <code>POD</code> format in the
   code, which is very convenient if the package is installed.
<br>
   We plan to make it available here via <code>pod2html</code> at some
   point (suggestions for a good tool would be welcome), but in the
   mean time you can browse the <code>POD</code> for the current
   release via
   <a href="http://search.cpan.org/search?dist=Test-Unit">CPAN</a>, as
   above.

</p>

<h2>Links related to PerlUnit aka. Test-Unit</h2>

Automated software testing is a large and growing area.  These links
may help you start your investigations.

<h3><a name="cpanlinks">Distribution, CPAN, other bug trackers</a></h3>

<ul>
<li>The <a href="http://testers.cpan.org/">CPAN Testers</a> make regular
    <a href="http://testers.cpan.org/show/Test-Unit.html">reports for Test-Unit</a>.</li>
<li><a href="http://rt.cpan.org/">rt.cpan.org</a> search for
    <a href="http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Unit">open Test-Unit bugs</a>.</li>
<li>The <a href="http://cpants.dev.zsi.at/dist/Test-Unit">CPANTS report</a>
    is a good game, but take the results with a pinch of salt! (Oct 2005)</li>
</ul>

<h3><a name="related">About unit testing</h3>
<ul>
<li><a href="http://www.xProgramming.com/">http://www.xProgramming.com/</a>,
    Extreme Programming site
<li><a href="http://JUnit.sourceforge.net/">http://JUnit.sourceforge.net/</a>,
    Java unit testing framework from which Perlunit was cloned
<li><a href="http://c2.com/cgi/wiki?PerlUnit">http://c2.com/cgi/wiki?PerlUnit</a>,
    A forest of data at the Wiki Wiki Web
</ul>

<h3><a name="addons">Other projects which support PerlUnit</a></h3>
<ul>
<li><a href="http://search.cpan.org/dist/Test-Unit-Runner-Xml/">Test::Unit::Runner::XML</a>,
    reports are in the same format as those produced by Ant's JUnit
    task.</li>
<li><a href="http://freshmeat.net/projects/GTestRunner">GTestRunner</a> aka.
	<a href="http://search.cpan.org/dist/Test-Unit-GTestRunner/">Test::Unit::GTestRunner</a>,
    a Gtk+ TestRunner GUI for Test::Unit.</li>
</ul>

    <h3><a name="othertest">Other projects for testing in Perl</a></h3>
    These are the "standard" testing modules,
    <ul>
      <li><a href="http://search.cpan.org/dist/Test-Simple/">Test::Simple</a>, includes Test::More and Test::Builder</li>
      <li><a href="http://search.cpan.org/dist/Test-Harness/">Test::Harness</a></li>
    </ul>
    There are more,
    <ul>
      <li><a href="http://search.cpan.org/dist/Test-Class/">Test::Class</a> (includes a good "SEE ALSO" list)</li>
      <li><a href="http://search.cpan.org/dist/Test-C2FIT/">Test::C2FIT</a></li>
      <li><a href="http://search.cpan.org/dist/Test-SimpleUnit/">Test::SimpleUnit</a></li>
    </ul>
    ...many more.

<hr>
<p align="right"><small>Last update:
$Date: 2005-11-27 15:41:13 $
</small></p>
</BODY>
</HTML>