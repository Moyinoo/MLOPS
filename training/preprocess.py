import pandas as pd

def preprocess_data(input_file, output_file):
    df = pd.read_csv(input_file)
    # Apply preprocessing steps
    df.to_csv(output_file, index=False)
