

```markdown
# GetCellPro

## Overview

GetCellPro calculates cell proximity metrics for given cell types and positions. This script is useful for analyzing cell-cell interactions in spatial transcriptomics data.

## Installation

Clone the repository:
```sh
git clone https://github.com/yourusername/GetCellPro.git
```

Load the script in your R environment:
```r
source('GetCellPro.R')
```

## Usage

Function: `GetCellPro`
Description: Calculates cell proximity metrics for given cell types and positions.

### Parameters

- `pos_list`: A list of data frames with cell positions and types. Each data frame should contain the following columns:
  - `posx`: X-coordinate of the cell center.
  - `posy`: Y-coordinate of the cell center.
  - `cel.typ`: Cell type.

- `cel_typ`: A vector of cell types to be considered.

- `min_cell_number`: Minimum number of cells for a cell type to be considered (default is 10).

- `max_dis`: Maximum distance for proximity calculation (default is 100).

### Returns

A data frame with proximity metrics.

## Example Usage

Load the example data and run the function as shown below:

```r
# Load the script
source('GetCellPro.R')

# Load example data
load('Example.Position.List.RData')

# Run the function
Proximity.score = GetCellPro(Position.List, cell.types)

# Print the result
print(Proximity.score)
```

### Example Output

Below is an example of the proximity score results:

|       | Cancer→Cancer | Th→Cancer | Alt MAC→Cancer | Cancer→Th | Th→Th | Alt MAC→Th | Cancer→Alt MAC | Th→Alt MAC | Alt MAC→Alt MAC |
|-------|---------------|-----------|----------------|-----------|-------|------------|----------------|------------|-----------------|
| IMC1  | 0.8985512     | 0.4866545 | 0.3637169      | 0.7882831 | 0.7721057 | 0.5548029 | 0.7406541      | 0.7051005  | 0.6340718       |
| IMC2  | 0.8452417     | 0.7446575 | 0.3600188      | 0.5512058 | 0.8786749 | 0.5252021 | 0.5766109      | 0.7923815  | 0.6871550       |
| IMC3  | 0.9138254     | 0.4566971 | 0.3436041      | 0.6763966 | 0.7170015 | 0.5560792 | 0.6368792      | 0.6992341  | 0.5447162       |
| IMC4  | 0.8817037     | 0.4632079 | 0.4267235      | 0.6988438 | 0.7969015 | 0.4972087 | 0.7424718      | 0.6656915  | 0.7453657       |
| IMC5  | 0.8848991     | 0.4452203 | 0.3508541      | 0.8300366 | 0.7840379 | 0.5420205 | 0.8493814      | 0.7532468  | 0.5797536       |
| IMC6  | 0.8834155     | 0.5454869 | 0.4340014      | 0.7796166 | 0.7799468 | 0.5603197 | 0.7827173      | 0.6765457  | 0.7119481       |
| IMC7  | 0.9020495     | 0.5032315 | 0.5201844      | 0.8594739 | 0.7154167 | 0.5415984 | 0.7552323      | 0.4367974  | 0.8492309       |
| IMC8  | 0.8989655     | 0.3882193 | 0.4189505      | 0.5353417 | 0.8099639 | 0.6523524 | 0.5867653      | 0.7121450  | 0.7251409       |
| IMC9  | 0.8824431     | 0.5386835 | 0.3538060      | 0.7889580 | 0.8185925 | 0.4092881 | 0.7201260      | 0.5653946  | 0.745476
