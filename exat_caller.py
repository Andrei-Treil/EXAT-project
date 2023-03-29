import pandas as pd
import subprocess

def main():
    df = pd.read_excel('variants_genes.xlsx',header=None)
    df_fixed = df[[0,3,4,5,6,7,8]]
    df_fixed[[3,4,5,6,7,8]] = df_fixed[[3,4,5,6,7,8]].applymap(fix_types)
    out = df_fixed.groupby(df_fixed[0]).aggregate({3:list,4:list,5:list,6:list,7:list,8:list})
    out.to_excel('cleaned.xlsx')


def fix_types(entry):
    return int(entry[0]) + int(entry[2]) 

#function to call R from Python, giving up on this for now
def call_scrip():
    command = "C:/Program Files/R/R-3.4.1/bin/R.exe"
    path = "C:/Users/andre/OneDrive/Desktop/EXAT (R)/EXAT.R"
    args = []
    genes = []
    genes.append(df_fixed.loc[0][1:8].tolist())
    genes.append(df_fixed.loc[1][1:8].tolist())
    genes.append(df_fixed.loc[2][1:8].tolist())
    name = df_fixed.loc[0][0]
    args.append(name)
    args.append(genes)
    args.append([8,7,2,4,5,6])
    args[1]= f"{args[1]}"
    args[2] = f"{args[2]}"
    cmd = [command,path] + args
    try:
        res = subprocess.check_output(cmd,universal_newlines=True,shell=True)
    except subprocess.CalledProcessError as e:
        print(e.output)


if __name__ == '__main__':
    main()