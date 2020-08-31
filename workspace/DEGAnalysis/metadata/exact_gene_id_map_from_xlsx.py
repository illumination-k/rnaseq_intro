import sys
from pprint import pprint

def parse_supplement_table3(path):
    """parse supplement table 3
    Args:
        path (str): path to supplment table 3
    Returns:
        dict: key=sheet_name, value=pandas dataframe of gene_id and gene_name 
    """
    import io
    import openpyxl
    import pandas as pd

    wb = openpyxl.load_workbook(path)
    d = {}
    for ws in wb.worksheets:
        key = ws.title.replace(" ", "_")
        csv = []
        for row in ws.rows:
            values = []
            for cell in row:
                v = ws[cell.coordinate].value
                if v is None:
                    values.append("")
                else:
                    values.append(str(v))
            csv.append(",".join(values))
        csv = "\n".join(csv)

        df = pd.read_csv(io.StringIO(csv))
        df = df[df.columns[:2]]
        df.columns = ["id", "name"]
        d[key] = df
    return d

def main():
    path = sys.argv[1:][0]
    d = parse_supplement_table3(path)
    pprint(d)

if __name__ == "__main__":
    main()