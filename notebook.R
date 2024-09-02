# Instal dan muat library yang diperlukan
if (!require(caret)) install.packages("caret", dependencies = TRUE)
library(caret)

# Memeriksa apakah file zip sudah ada
if (!file.exists("pima-indians-diabetes-database.zip")) {
  system("kaggle datasets download -d uciml/pima-indians-diabetes-database")
}

# Memeriksa apakah folder sudah ada
if (!dir.exists("pima-indians-diabetes-database")) {
  system("unzip pima-indians-diabetes-database.zip")
}

# system("kaggle datasets download -d uciml/pima-indians-diabetes-database")
# system("unzip pima-indians-diabetes-database.zip")

data <- read.csv("diabetes.csv")
head(data)

"""## Data Understanding

### 1. Collecting Data
"""

## show dimensions of the train and test dataset
dim(data) # 9 variables

## show first few lines of the data dataset
head(data)

# use glimpse() or str() to show data structure
str(data)

# check variable names
names(data)

"""### 2. Describe Data"""

summary(data)

"""### 3. Validation Data"""

# Instalasi paket jika diperlukan
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(gridExtra)) install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

# Buat daftar plot untuk setiap kolom kategorikal
plot_list <- lapply(names(data), function(col) {
  ggplot(data, aes_string(x = col)) +
    geom_bar(fill = 'steelblue') +  # Membuat count plot (bar plot) serupa dengan sns.countplot
    theme_minimal() +               # Menggunakan tema minimal
    ggtitle(col) +                  # Menambahkan judul berdasarkan nama kolom
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Memutar teks sumbu-x jika diperlukan
})

# Tampilkan plot dalam grid
do.call(grid.arrange, c(plot_list, ncol = 2))

if (!require(reshape2)) install.packages("reshape2")
library(reshape2)

# Membuat histogram menggunakan ggplot2
ggplot(data = melt(data), mapping = aes(x = value)) +
  geom_histogram(bins = 10) +
  facet_wrap(~variable, scales = 'free_x')

"""## Data Preparation

### 1. Cleaning Data
"""

# Checking Missing Value
sum(is.na(data))

# # Menghapus baris dengan missing values
# data_clean <- na.omit(data)

# Misalkan Anda memiliki dataframe bernama `data`
duplikat <- duplicated(data)

# Menampilkan baris yang duplikat
baris_duplikat <- data[duplikat, ]
print(baris_duplikat)

# Menghitung jumlah baris duplikat
jumlah_duplikat <- sum(duplikat)
print(jumlah_duplikat)

# # Menghapus baris duplikat, hanya menyimpan yang unik
# data_baru <- data[!duplikat, ]

"""### 2. Data Selection"""

cor(data)

if (!require(ggcorrplot)) install.packages("ggcorrplot")

library(ggcorrplot)
corr <- round(cor(data), 1)

# Plot
ggcorrplot(corr,
           type = "lower",
           lab = TRUE,
           lab_size = 5,
           colors = c("tomato2", "white", "springgreen3"),
           title="Correlation Matrix",
           ggtheme=theme_bw)

# par(mfrow=c(2, 3))  # divide graph area in 2 columns
# boxplot(data$Pregnancies, main="Pregnancies")
# boxplot(data$Glucose, main="Glucose")
# boxplot(data$BloodPressure, main="BloodPressure")
# boxplot(data$Insulin, main="Insulin")
# boxplot(data$BMI, main="BMI")
# boxplot(data$DiabetesPedigreeFunction, main="DiabetesPedigreeFunction")
# boxplot(data$Age, main="Age")
# boxplot(data$Outcome, main="Outcome")

# Menghitung matriks korelasi
korelasi_all <- cor(data)

# Mengambil korelasi dengan kolom 'Outcome'
Korelasistats <- korelasi_all[,'Outcome']

# Mengurutkan korelasi
urutkan <- sort(Korelasistats, decreasing = TRUE)
print(urutkan)

# # Drop Cols
# drops = c('BloodPressure')
# data_select =  data[ , !(names(data) %in% drops)]

"""### 3. Data Transformation"""

# Menormalisasi data menggunakan scale()
scaled_data <- scale(data)

# Menampilkan data yang sudah dinormalisasi
dim(scaled_data)
head(scaled_data)

"""## Modelling & Evaluation

### 1. Split Data
"""

# Install dan muat paket dplyr
if (!require(dplyr)) install.packages("dplyr")
library(dplyr)

# Split data menjadi training (80%) dan testing (20%)
set.seed(123)
train_data <- sample_frac(data, 0.8)
test_data <- anti_join(data, train_data)

# Pisahkan fitur dan target untuk training dan testing
X_train <- train_data %>% select(-Outcome)
Y_train <- train_data$Outcome
X_test <- test_data %>% select(-Outcome)
Y_test <- test_data$Outcome

"""### 2. Build Model & Evaluation"""

# Instal dan muat library yang diperlukan
if (!require(e1071)) install.packages("e1071")
library(e1071)

# Membangun model Naive Bayes
set.seed(123)
nb_model <- naiveBayes(Outcome ~ ., data = train_data)

# Membuat prediksi pada dataset test
pred_nb <- predict(nb_model, newdata = X_test)

# Menyelaraskan level faktor
levels <- union(levels(factor(Y_test)), levels(factor(pred_nb)))

Y_test <- factor(Y_test, levels = levels)
pred_nb <- factor(pred_nb, levels = levels)

# Evaluasi kinerja model menggunakan Confusion Matrix
confusionMatrix(pred_nb, Y_test)