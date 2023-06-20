#!/bin/bash

zipzip ()
{
pass=${@:2}
if $(7z l -slt $1 | grep -q ZipCrypto)
then
    for pa in $pass
    do
        unzip -P $pa -o $1 1>/dev/null 2>>./log.txt; checkLogFile
    done
else
    unzip -q -o $1 1>/dev/null 2>>./log.txt; checkLogFile
    rm -f $1
fi
}

checkLogFile ()
{
var3=10
lines=$(wc -l < ./log.txt)
if [ "$lines" -le "$var3" ]
then
    sed -i '/^$/d' ./log.txt
else
while [ "$lines" -gt "$var3" ]
do
    sed -i '/^$/d' ./log.txt
    sed -i 1d ./log.txt
    lines=$(wc -l < ./log.txt)
done
fi
}

checkFinalLineAmount ()
{
finalLines=$(wc -l < ./log.txt)
var0=0
if [ "$finalLines" -gt "$var0" ]
then
    echo "Errors have occurred. To view these, visit log.txt"
fi
}

current=`pwd`

if [ "$1" == "-o" ] && [ "$2" == "-d" ] && [ "$4" == "-p" ]
then
    if [[ -d $3 ]]
    then
        touch log.txt 2>>./log.txt; checkLogFile
        pass=${@:5}
        for item in $pass
        do
            if ! [[ "$item" =~ ^[a-zA-Z0-9_/\\-]+$ ]]
            then
                echo "Parameter error: one of more invalid passwords"
                exit 1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            basename=$(basename -- "$file") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$file" "$pass" 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            fi
        done

        allfilesdestination=$(find $3 -type f)
        for filename in $allfilesdestination; do
            basenamenew=$(basename -- "$filename") 2>>./log.txt; checkLogFile
            extensionnew=${basenamenew##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filename" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file $3 2>>./log.txt; checkLogFile
            fi
        done

        cd "$3"
        allfilesfinal=$(find . -type f)
        for file in $allfilesfinal; do
            if [ "$file" != "./log.txt" ]
            then
                d=$(date -r "$file" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "$d" 2>>./log.txt; checkLogFile
                mv "$file" "$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"
        rm ./log.txt

    else
        echo "$2 is not a valid directory"
    fi

elif [ "$1" == "-o" ] && [ "$2" == "-d" ]
then
    if [[ -d $3 ]]
    then
        touch log.txt 2>>./log.txt; checkLogFile

        #Hier moeten we alle files listen in de current directory
        allfiles=$(find . -type f)

        #Here we move up all files to current directory
        for file in $allfiles; do
            basename=$(basename -- "$file") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$file" 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            fi
        done

        allfilesdestination=$(find $3 -type f)
        for filename in $allfilesdestination; do
            basename=$(basename -- "$filename") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filename" 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file $3 2>>./log.txt; checkLogFile
            fi
        done

        cd "$3"
        allfilesfinal=$(find . -type f)
        for file in $allfilesfinal; do
            if [ "$file" != "./log.txt" ]
            then
                d=$(date -r "$file" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "$d" 2>>./log.txt; checkLogFile
                mv "$file" "$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"
        rm ./log.txt

    else
        echo "$2 is not a valid directory"
    fi

elif [ "$1" == "-d" ] && [ "$#" -eq 2 ]
then
    if [[ -d $2 ]]
    then
        touch log.txt 2>>./log.txt; checkLogFile

        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        allfilesdestination=$(find $2 -type f)
        for filename in $allfilesdestination; do
            basename=$(basename -- "$filename") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filename" 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            fi
        done

        current=`pwd`

        dubbel=$(find $"`pwd`/" $"$2/" -printf '%P\n' | sort | uniq -d)
        cd "$2"
        for dubbelItem in $dubbel
        do
            filename=$(basename -- "$dubbelItem") 2>>./log.txt; checkLogFile
            extension=${filename##*.} 2>>./log.txt; checkLogFile
            filename=${filename%.*} 2>>./log.txt; checkLogFile
            z=1
            case `basename "$dubbelItem"` in
            .* )
                    mv "$dubbelItem" "$filename.$extension$((z++))" 2>>./log.txt; checkLogFile
                ;;
            *.* )
                    mv "$dubbelItem" "$filename$((z++)).$extension" 2>>./log.txt; checkLogFile
                ;;
            * )
                    mv "$dubbelItem" "$filename$((z++))" 2>>./log.txt; checkLogFile
                ;;
            esac
        done

        cd "$current"

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file $2 2>>./log.txt; checkLogFile
            fi
        done

        cd "$2"
        allfilesfinal=$(find . -type f)
        for file in $allfilesfinal; do
            if [ "$file" != "./log.txt" ]
            then
                d=$(date -r "$file" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "$d" 2>>./log.txt; checkLogFile
                mv "$file" "$d" 2>>./log.txt; checkLogFile
            fi
        done

       declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"
        rm ./log.txt

    else
        echo "$2 is not a valid directory"
    fi

elif [ "$1" == "-d" ] && [ "$3" == "-p" ]
then
    if [[ -d $2 ]]
    then
        touch log.txt 2>>./log.txt; checkLogFile

        pass=${@:4}
        for item in $pass
        do
            if ! [[ "$item" =~ ^[a-zA-Z0-9_/\\-]+$ ]]
            then
                echo "Parameter error: one of more invalid passwords"
                exit 1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            basename=$(basename -- "$file") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$file" "$pass" 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $file 2>>./log.txt; checkLogFile
                rm -f $file 2>>./log.txt; checkLogFile
            fi
        done

        allfilesdestination=$(find $2 -type f)
        for filename in $allfilesdestination; do
            basenamenew=$(basename -- "$filename") 2>>./log.txt; checkLogFile
            extensionnew=${basenamenew##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filename" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filename 2>>./log.txt; checkLogFile
                rm -f $filename 2>>./log.txt; checkLogFile
            fi
        done

        current=`pwd`

        dubbel=$(find $"`pwd`/" $"$2/" -printf '%P\n' | sort | uniq -d)
        cd "$2"
        for dubbelItem in $dubbel
        do
            filename=$(basename -- "$dubbelItem") 2>>./log.txt; checkLogFile
            extension=${filename##*.} 2>>./log.txt; checkLogFile
            filename=${filename%.*} 2>>./log.txt; checkLogFile
            z=1
            case `basename "$dubbelItem"` in
            .* )
                    mv "$dubbelItem" "$filename.$extension$((z++))" 2>>./log.txt; checkLogFile
                ;;
            *.* )
                    mv "$dubbelItem" "$filename$((z++)).$extension" 2>>./log.txt; checkLogFile
                ;;
            * )
                    mv "$dubbelItem" "$filename$((z++))" 2>>./log.txt; checkLogFile
                ;;
            esac
        done

        cd "$current"

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file $2 2>>./log.txt; checkLogFile
            fi
        done

        cd "$2"
        allfilesfinal=$(find . -type f)
        for file in $allfilesfinal; do
            if [ "$file" != "./log.txt" ]
            then
                d=$(date -r "$file" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "$d" 2>>./log.txt; checkLogFile
                mv "$file" "$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"
        rm ./log.txt

    else
        echo "$2 is not a valid directory"
    fi

elif [ "$1" == "-o" ] && [ "$2" == "-p" ]
then
    touch log.txt 2>>./log.txt; checkLogFile

    pass=${@:3}
    for item in $pass
    do
        if ! [[ "$item" =~ ^[a-zA-Z0-9_/\\-]+$ ]]
        then
            echo "Parameter error: one of more invalid passwords"
            exit 1
        fi
    done

    if [ -d `pwd`/archive/ ]
    then
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        n=1
        isFinished=0
        while [ $isFinished -eq 0 ]
        do
            if [ -d "archive$n" ]
            then
                n=$((n+1)) 2>>./log.txt; checkLogFile
            else
                mkdir archive$n 2>>./log.txt; checkLogFile
                isFinished=1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive$n 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive$n/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive$n/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    else
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        mkdir archive 2>>./log.txt; checkLogFile

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    fi

elif [ "$1" == "-o" ] && [ "$#" -eq 1 ]
then
    touch log.txt 2>>./log.txt; checkLogFile

    if [ -d `pwd`/archive/ ]
    then
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        n=1
        isFinished=0
        while [ $isFinished -eq 0 ]
        do
            if [ -d "archive$n" ]
            then
                n=$((n+1)) 2>>./log.txt; checkLogFile
            else
                mkdir archive$n 2>>./log.txt; checkLogFile
                isFinished=1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive$n 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive$n/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive$n/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    else
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        mkdir archive 2>>./log.txt; checkLogFile

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"
    fi


elif [ "$1" == "-p" ]
then
    touch log.txt 2>>./log.txt; checkLogFile

    pass=${@:2}
    for item in $pass
    do
        if ! [[ "$item" =~ ^[a-zA-Z0-9_/\\-]+$ ]]
        then
            echo "Parameter error: one of more invalid passwords"
            exit 1
        fi
    done

    if [ -d `pwd`/archive/ ]
    then
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        n=1
        isFinished=0
        while [ $isFinished -eq 0 ]
        do
            if [ -d "archive$n" ]
            then
                n=$((n+1)) 2>>./log.txt; checkLogFile
            else
                mkdir archive$n 2>>./log.txt; checkLogFile
                isFinished=1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive$n 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive$n/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive$n/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    else
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" "$pass" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        mkdir archive 2>>./log.txt; checkLogFile

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    fi

elif [ "$#" -eq 0 ]
then
    touch log.txt 2>>./log.txt; checkLogFile

    if [ -d `pwd`/archive/ ]
    then
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed")  2>>./log.txt; checkLogFile
            extension=${basename##*.}  2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        n=1
        isFinished=0
        while [ $isFinished -eq 0 ]
        do
            if [ -d "archive$n" ]
            then
                n=$((n+1)) 2>>./log.txt; checkLogFile
            else
                mkdir archive$n 2>>./log.txt; checkLogFile
                isFinished=1
            fi
        done

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive$n 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive$n/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive$n/$d" 2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    else
        allfiles=$(find . -type f)
        for filed in $allfiles; do
            basename=$(basename -- "$filed") 2>>./log.txt; checkLogFile
            extension=${basename##*.} 2>>./log.txt; checkLogFile
            if [ $extension == "zip" ]
            then
                zipzip "$filed" 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "tar" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            elif [ $extension == "gz" ]
            then
                tar -xf $filed 2>>./log.txt; checkLogFile
                rm -f $filed 2>>./log.txt; checkLogFile
            fi
        done

        mkdir archive 2>>./log.txt; checkLogFile

        allfiles=$(find . -type f)
        for file in $allfiles; do
            if [ "$file" != "./log.txt" ]
            then
                mv $file archive 2>>./log.txt; checkLogFile
            fi
        done

        allfilesfinal=$(find . -type f)
        for files in $allfilesfinal; do
            if [ "$files" != "./log.txt" ]
            then
                d=$(date -r "$files" +%Y-%m-%d) 2>>./log.txt; checkLogFile
                mkdir -p "archive/$d" 2>>./log.txt; checkLogFile
                mv "$files" "archive/$d"  2>>./log.txt; checkLogFile
            fi
        done

        declare -i amountwithoutext
        amountwithoutext=0
        wth=$(find . -type f ! -name '*.*' | sed 's|.*\.||' | sort)
        for withoutext in $wth
        do
            amountwithoutext=$((amountwithoutext+1))
        done
        if [ $amountwithoutext -gt 0 ]
        then
            echo "      $amountwithoutext without extension"
        fi
        echo "$(find . -type f -name '*.*' | sed 's|.*\.||' | sort | uniq -c)"

    fi

else
    echo "Parameter error, please run the script using a valid combination of parameters (or without any at all)"
fi
cd "$current"
checkFinalLineAmount
