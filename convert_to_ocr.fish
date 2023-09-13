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
    
    # Check if the processed PDF already exists in the output directory
    if not test -e "$output_dir/$new_filename"
        # Run ocrmypdf on the file
        ocrmypdf -s -l swe+eng+osd "$pdf" "$output_dir/$new_filename"

        # Increment the completed counter and report the progress
        set completed (math $completed+1)
        echo "Completed $filename. Now done $completed out of $total_pdfs"
    else
        # Skip it if it already exists
        echo "Skipping $filename as it already exists in the output directory."

        # Increment the completed counter
        set completed (math $completed+1)
    end
end

echo "All done!"