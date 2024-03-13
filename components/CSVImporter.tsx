"use client";

import { useState } from "react";
import Papa from "papaparse";

const CSVImporter: React.FC = () => {
    const [data, setData] = useState<string[][] | null>(null);

    const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const file = event.target.files?.[0];
        if (!file) return;

        // Utilizar FileReader para leer el archivo como texto
        const reader = new FileReader();
        reader.onload = (e) => {
            if (e.target?.result) {
                // Parsear el texto del archivo usando Papa Parse
                Papa.parse<string[]>(e.target.result.toString(), {
                    complete: (result) => {
                        setData(result.data);
                    },
                    header: true, // Suponiendo que el archivo CSV no tiene una fila de encabezado
                });
            }
        };
        reader.readAsText(file);
    };

    return (
        <div>
            {/* Input para seleccionar un archivo */}
            <input type="file" onChange={handleFileChange} accept=".csv" />
            <div className="flex-1 my-10">
                {/* Mostrar los datos del archivo CSV */}
                {data?.map((row, rowIndex) => (
                    <div key={rowIndex}>
                        {row.map((cell, cellIndex) => (
                            <span key={`${rowIndex}-${cellIndex}`}>{cell} </span>
                        ))}
                    </div>
                ))}
            </div>
        </div>
    );
};

export default CSVImporter;
