#!/bin/bash

# Caminho para a pasta com os PDFs originais
INPUT_DIR="WebNecroData/pdfs2"

# Caminho para a pasta onde os arquivos processados serão salvos
OUTPUT_DIR="WebNecroData/pdfs-ocr"

# Caminho para o script Python
EXTRACT_SCRIPT="WebNecroData/extract.py"

# Caminho para o arquivo CSV de saída
OUTPUT_CSV="WebNecroData/output.csv"

# Verifique se o diretório de saída existe, caso contrário, crie-o
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Loop sobre todos os arquivos PDF na pasta de entrada
for pdf_file in "$INPUT_DIR"/*.pdf; do
  # Extraia o nome do arquivo sem extensão
  base_name=$(basename "$pdf_file" .pdf)
  # Defina o caminho do arquivo de saída
  output_file="$OUTPUT_DIR/$base_name.pdf"
  # Aplique o OCR ao PDF
  ocrmypdf "$pdf_file" "$output_file"
done

echo "OCR concluído!"

# Execute o script Python para extrair informações dos PDFs processados e salvar no CSV
python3 "$EXTRACT_SCRIPT" "$OUTPUT_DIR" "$OUTPUT_CSV"

echo "Extração de informações concluída e salva em $OUTPUT_CSV!"
