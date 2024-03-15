"use client";

import { useEffect, useState } from "react";
import Papa from "papaparse";

const CSVImporter: React.FC = () => {
    const [data, setData] = useState<string[][] | null>(null);
    const [headers, setHeaders] = useState<string[] | null>(null);
    const [musician, setMusician] = useState<{
        id: string;
        name: string;
    } | null>(null);

    useEffect(() => {
        upsertMusicians();
    }, [data]);

    const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const file = event.target.files?.[0];
        if (!file) return;

        // Utilizar FileReader para leer el archivo como texto
        const reader = new FileReader();
        reader.onload = (e) => {
            if (e.target?.result) {
                // Parsear el texto del archivo usando Papa Parse
                Papa.parse<string[]>(e.target.result.toString(), {
                    complete: (result: Papa.ParseResult<string[]>) => {
                        // Los datos se encontrarán en result.data
                        setData(result.data);
                        // Los encabezados se encontrarán en result.meta.fields
                        setHeaders(result.meta.fields ?? null);
                    },
                    header: true, // Indica que el archivo CSV tiene una fila de encabezado
                    delimiter: ';' // Establece el delimitador correcto para tu CSV
                });
            }
        };
        reader.readAsText(file);
    };

    const upsertMusicians = () => {
        if (data && headers) {
            const musicianData: { id: string; name: string }[] = [];
            const nameRow = data[0]; // Obtener la fila con los nombres de los músicos

            headers.forEach((header: string, headerIndex: number) => {
                if (headerIndex >= 3) {
                    // A partir del cuarto valor del encabezado (el primero es 5)
                    const musician: { id: string; name: string } = {
                        id: header, // Usar el valor del encabezado como parte del id
                        name: nameRow[header as unknown as number], // Obtener el nombre del músico de la misma columna
                    };
                    musicianData.push(musician);
                }
            });

            setMusician(musicianData[0]);
        }
    };

    return (
        <div>
            {/* Input para seleccionar un archivo */}
            <input type="file" onChange={handleFileChange} accept=".csv" />
            <div className="flex-1 my-10">
                {/* Mostrar los datos del archivo CSV */}
                {/* {data?.map((row, rowIndex) => (
                    <div key={rowIndex}>
                        {headers?.map((header, headerIndex) => (
                            <div key={`${rowIndex}-${headerIndex}`}>
                                <strong>{header}: </strong>
                                {row[headerIndex]}
                            </div>
                        ))}
                    </div>
                ))} */}
                {musician && (
                    <>
                        <strong>{musician.id}</strong>
                        <p>{musician.name}</p>
                    </>
                )}
            </div>
        </div>
    );
};

export default CSVImporter;
