#!/usr/bin/perl

use strict;

sub getExecPath
{
    my $path = __FILE__;
    for (;;) {
        my $dir = `dirname $path`;
        chomp $dir;
        if (-e "$dir/PEEOS.h") {
            return $dir;
        }
        if (not -l $path) {
            last;
        }
        my $newpath = `readlink $path`;
        chomp $newpath;
        if (not $newpath) {
            last;
        }
        $path = $newpath;
    }
    print "Error: PEEOS.h not found\n";
    exit(1);
}

my $execPath = getExecPath();
print "execPath: '$execPath'\n";

my $buildPath = "$execPath/Build";
print "buildPath: '$buildPath'\n";

my $objectsPath = "$buildPath/Objects";
my $logsPath = "$buildPath/Logs";

sub cflagsForFile
{
    my ($path) = @_;
    if ($path =~ m/\/external\/tidy-html5-5.6.0\//) {
        return "-I$execPath/external/tidy-html5-5.6.0/include -I$execPath/external/tidy-html5-5.6.0/src";
    }
    if ($path eq "$execPath/lib/lib-htmltidy.m") {
        return "-I$execPath/external/tidy-html5-5.6.0/include";
    }
    if ($path eq "$execPath/misc/misc-gmime.m") {
        return `pkg-config --cflags gmime-3.0`;
    }
    return '';
}

sub ldflagsForFile
{
    my ($path) = @_;
    if ($path eq "$execPath/linux/linux-x11.m") {
        return '-lX11 -lXext -lXfixes';
    }
    if ($path eq "$execPath/linux/linux-opengl.m") {
        return '-lGL';
    }
    if ($path eq "$execPath/misc/misc-gmime.m") {
        return `pkg-config --libs gmime-3.0`;
    }
    if ($path eq "$execPath/misc/misc-pcre.m") {
        return '-lpcre';
    }
    if ($path eq "$execPath/misc/misc-sox.m") {
        return '-lfftw3';
    }
    if ($path eq "$execPath/misc/misc-jpeg.m") {
        return '-ljpeg';
    }
    if ($path eq "$execPath/misc/misc-png.m") {
        return '-lpng';
    }
    if ($path eq "$execPath/misc/misc-libz.m") {
        return '-lz';
    }
    if ($path eq "$execPath/misc/object-nes.m") {
        return '-ldl';
    }
    return '';
}

sub ldflagsForAllFiles
{
    my @files = @_;
    my @strs = map { ldflagsForFile($_) } @files;
    @strs = grep { $_ } @strs;
    return join ' ', @strs;
}




sub allSourceFiles
{
    my $cmd = <<EOF;
find -L
    $execPath/linux/
	$execPath/lib/
    $execPath/objects/
    $execPath/misc/
    $execPath/external/jsmn
    $execPath/external/tidy-html5-5.6.0/src
    -not -name '.*'
EOF
    $cmd =~ s/\n/ /g;
    my @lines = `$cmd`;
    @lines = grep /\.(c|m|mm|cpp)$/, @lines;
    chomp(@lines);
    return @lines;
}

sub compileSourcePath
{
    my ($sourcePath) = @_;

    my $objectPath = objectPathForPath($sourcePath);
    my $logPath = logPathForPath($sourcePath);

    my $cflags = cflagsForFile($sourcePath);

#    -Werror=objc-method-access
#clang -c -O0 -g -pg
	my $cmd = <<EOF;
clang -c -O3
    -Werror=implicit-function-declaration
    -Werror=return-type
    -I$execPath/external/libobjc2/build/include
    -I$execPath/external/jsmn
    -I$execPath
    -I$execPath/linux
    -I$execPath/lib
    -I$execPath/objects
    -I$execPath/misc
    $cflags
    -DBUILD_FOUNDATION
    -DBUILD_FOR_LINUX
    -fobjc-nonfragile-abi
    -fblocks
    -o $objectPath $sourcePath 2>>$logPath
EOF

    writeTextToFile("${cmd}\n---CUT HERE---\n", $logPath);

    $cmd =~ s/\n/ /g;
	system($cmd);
}

sub linkSourcePaths
{
    my @arr = @_;
    my $ldflags = ldflagsForAllFiles(@arr);
    @arr = map { objectPathForPath($_) } @arr;
    my $objectFiles = join ' ', @arr;
#    -pg
    my $cmd = <<EOF;
clang -o $execPath/peeos
    -fobjc-nonfragile-abi
    -fblocks
    $objectFiles
    $execPath/external/libobjc2/build/*.o
    -lpthread
    -lm
    $ldflags
EOF
    writeTextToFile($cmd, "$logsPath/LINK");
    $cmd =~ s/\n/ /g;
    system($cmd);
}

##########


sub writeTextToFile
{
    my ($text, $path) = @_;

    local *FH;
    open FH, ">$path";
    print FH $text;
    close FH;
}

sub makeDirectory
{
    my ($path) = @_;
    if (-e $path) {
        if (-d $path) {
            return;
        }
        die("already exists but is not a directory: '$path'");
    }
    mkdir $path, 0755 or die("unable to make directory '$path'");
}

sub nameForPath
{
    my ($path) = @_;
    my @comps = split '/', $path;
    my $str = $comps[-1];
    my @arr = split '\.', $str;
    return $arr[0];
}

sub modificationDateForPath
{
    my ($path) = @_;
    return (stat ($path))[9];
}

sub objectPathForPath
{
    my ($sourcePath) = @_;
    my $name = nameForPath($sourcePath);
    my $objectPath = $objectsPath . "/" . $name . ".o";
    return $objectPath;
}
 
sub logPathForPath
{
    my ($sourcePath) = @_;
    my $name = nameForPath($sourcePath);
    my $logPath = $logsPath . "/" . $name . ".log";
    return $logPath;
}
sub statusForPath
{
    my ($sourcePath) = @_;
    my $objectPath = objectPathForPath($sourcePath);
    my $logPath = logPathForPath($sourcePath);
    my $dateForSource = modificationDateForPath($sourcePath);
    my $dateForObject = modificationDateForPath($objectPath);
    my $dateForLog = modificationDateForPath($logPath);
    if (not -e $sourcePath) {
        return "*sourceDoesNotExist";
    }
    if (-e $objectPath) {
        if ($dateForSource > $dateForObject) {
            # needToCompile
        } else {
            return "ok";
        }
    } else {
        # needToCompile
    }
    if (not -e $logPath) {
        return "*needToCompile";
    }
    if ($dateForSource > $dateForLog) {
        return "*needToCompile";
    }
    return "*compileError";
}


makeDirectory($buildPath);
makeDirectory($objectsPath);
makeDirectory($logsPath);

my @lines = allSourceFiles();
foreach my $line (@lines) {
    my $status = statusForPath($line);
    if ($status eq 'ok') {
        next;
    }

    print "Compiling " . nameForPath($line) . "\n";
    compileSourcePath($line);
    $status = statusForPath($line);


    if ($status eq 'ok') {
        print nameForPath($line) . ": " . "$status\n";
        next;
    }
    my $logPath = logPathForPath($line);
    print `cat $logPath`;
    print nameForPath($line) . ": $status\n";
    exit(0);
}

print "Linking\n";
linkSourcePaths(@lines);

