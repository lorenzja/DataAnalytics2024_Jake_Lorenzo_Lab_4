# DataAnalytics2024_Jake_Lorenzo_Lab_4

Results Table from running KNN model on the original dataset
   recall precision        f1
1 0.8437500 0.9310345 0.8852459
2 0.8103448 0.6619718 0.7286822
3 0.6000000 0.6875000 0.6407767

Results Table from running KNN model on the pca analysis dataset (PC1, PC2, and PC3)
   recall precision        f1
1 0.9666667 1.0000000 0.9830508
2 0.9850746 0.9295775 0.9565217
3 0.9400000 0.9791667 0.9591837

Results Table from removing the three variables that least influenced PC1, rerunning the PCA and KNN models
     recall precision        f1
1 0.9500000 0.9827586 0.9661017
2 0.9850746 0.9295775 0.9565217
3 0.9200000 0.9583333 0.9387755
