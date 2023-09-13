#!/usr/bin/fish

# Variables for source and destination directories
set source_dir "raw_pdfs"
set output_dir "ocrd_pdfs"

# Check if the output directory exists, if not, create it
if not test -d $output_dir
    mkdir -p $output_dir
end

# Count the total number of PDFs
set total_pdfs (count $source_dir/*.pdf)

echo "Total PDFs to convert: $total_pdfs"

# Initialize a counter for completed conversions
set completed 0

# Loop through each PDF in the source directory
for pdf in $source_dir/*.pdf
    # Extract the filename without the path and extension
    set filename (basename $pdf .pdf)
    
    # Append "_ocr" to the filename
    set new_filename "$filename"_ocr.pdf
    
    # Run ocrmypdf on the file
    ocrmypdf -s "$pdf" "$output_dir/$new_filename"

    # Increment the completed counter and report progress
    set completed (math $completed+1)
    echo "Completed $filename. Now done $completed out of $total_pdfs"
end

echo "All done!"