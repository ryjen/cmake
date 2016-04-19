#!/bin/sh

function copy_file {

  if [ -f $2 ]; then
    echo "$2 already exists, overwrite (y/n)? "
    read -n 1 c

    if [ $c != 'y' ] && [ $c != 'Y' ]; then
      exit 1
    fi
  fi

  cp -f $1 $2
}

if [ ! -x $(which ed) ]; then
	echo "ed binary required for this script to work."
	exit 1
fi

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Syntax: $0 <name> <version> <description>"
	exit 1
fi

basedir=`dirname $0`
template="$basedir/list_template.cmake"
listfile="./CMakeLists.txt"

copy_file $template $listfile

echo "Generating $listfile..."

echo "Setting project name:        $1"
ed -s $listfile <<EOF
,s/@PROJECT_NAME@/$1/g
w
EOF

echo "Setting project version:     $2"
ed -s $listfile <<EOF
,s/@PROJECT_VERSION@/$2/g
w
EOF

echo "Setting project description: $3"
ed -s $listfile <<EOF
,s/@PROJECT_DESCRIPTION@/$3/g
w
EOF

srcdir="./src"
srctemplate="$basedir/src_template.cmake"
srclistfile="$srcdir/CMakeLists.txt"

echo "Creating $srclistfile..."

if [ ! -d $srcdir ]; then
  mkdir $srcdir
fi

copy_file $srctemplate $srclistfile

testsdir="./tests"
teststemplate="$basedir/tests_template.cmake"
testslistfile="$testsdir/CMakeLists.txt"

echo "Creating $testslistfile..."
if [ ! -d $testsdir ]; then
  mkdir $testsdir
fi

copy_file $teststemplate $testslistfile

echo "Done."

exit 0

