# Diabetes Classification
![dataset-cover](https://github.com/user-attachments/assets/da562a95-1952-4025-ab68-24fb859b48ea)

## Domain Proyek

Domain Poryek : Kesehatan

Judul : Diabetes Classification

### Latar Belakang
Diabetes mellitus adalah penyakit kronis yang terjadi ketika pankreas tidak dapat memproduksi insulin yang cukup atau ketika hormon insulin tidak dapat digunakan secara efektif oleh tubuh. Kondisi ini menyebabkan peningkatan kadar gula darah yang dikenal sebagai hiperglikemia. Jika tidak dikendalikan, diabetes dapat menyebabkan dampak jangka panjang yang merusak berbagai sistem tubuh, terutama pembuluh darah dan saraf. Menurut data dari National Institute of Diabetes and Digestive and Kidney Diseases, deteksi dini diabetes sangat penting untuk mengelola dan mengendalikan penyakit ini.

Dataset Pima Indians Diabetes, menyediakan variabel-variabel yang relevan untuk mendeteksi potensi diabetes. Variabel-variabel ini termasuk jumlah kehamilan, konsentrasi glukosa plasma, tekanan darah diastolik, ketebalan lipatan kulit triceps, kadar insulin, indeks massa tubuh (BMI), fungsi genealogis diabetes, dan usia. Dengan menggunakan data ini, tujuan dari proyek ini adalah untuk mengembangkan model prediksi yang dapat memprediksi kemungkinan seseorang mengidap diabetes.

Menurut sebuah [penelitian](https://jurnal.untag-sby.ac.id/index.php/jitsc/article/view/9945), deteksi dini diabetes dapat dilakukan dengan menggunakan kecerdasan buatan. Penelitian tersebut menyebutkan bahwa dengan memanfaatkan algoritma klasifikasi berbasis kesamaan dan P-Probabilistic Extension, akurasi prediksi potensi diabetes dapat mencapai 75,38%. Ini menunjukkan bahwa metode ini dapat lebih efektif dibandingkan dengan algoritma K-nearest neighbor (KNN) yang sering digunakan dalam dataset ini. Penelitian ini menekankan pentingnya pemilihan fitur yang representatif dan penerapan algoritma yang tepat untuk meningkatkan performa deteksi dini diabetes.

Dalam proyek ini, kami bertujuan untuk menerapkan model klasifikasi menggunakan dataset Pima Indians Diabetes dengan menerapkan algoritma Naive Bayes dengan harapan model ini dapat memberikan wawasan yang berharga dan kontribusi signifikan dalam upaya mengurangi prevalensi diabetes melalui deteksi dini yang lebih akurat.

## Business Understanding

### Problem Statements
Berdasarkan latar belakang di atas, berikut akan dijabarkan pokok permasalahan yang dibahas dalam proyek sebagai berikut.
- Bagaimana mengembangkan model yang dapat mengklasifikasikan kemungkinan seseorang mengidap diabetes?

### Goals
- Mengembangkan model yang dapat mengklasifikasikan kemungkinan seseorang mengidap diabetes



## Data Understanding
### EDA - Deskripsi Variabel
**Informasi Datasets**


| Jenis | Keterangan |
| ------ | ------ |
| Title | Pima Indians Diabetes Database |
| Source | [Kaggle](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database/data) |
| License | [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) |
| Visibility | Publik |
| Tags | _Earth and Nature, Health, Diabetes, India, Healthcare_ |
| Usability | 8.82 |

Berikut informasi pada dataset: 

| A_id | Pregnancies | Glucose | BloodPressure | SkinThickness | Insulin | BMI  | DiabetesPedigreeFunction | Age | Outcome |
|------|-------------|---------|---------------|---------------|---------|------|--------------------------|-----|---------|
| 1    | 6           | 148     | 72            | 35            | 0       | 33.6 | 0.627                    | 50  | 1       |
| 2    | 1           | 85      | 66            | 29            | 0       | 26.6 | 0.351                    | 31  | 0       |
| 3    | 8           | 183     | 64            | 0             | 0       | 23.3 | 0.672                    | 32  | 1       |
| 4    | 1           | 89      | 66            | 23            | 94      | 28.1 | 0.167                    | 21  | 0       |
| 5    | 0           | 137     | 40            | 35            | 168     | 43.1 | 2.288                    | 33  | 1       |



Tabel 1. EDA Deskripsi Variabel

Dilihat dari _Tabel 1. EDA Deskripsi Variabel_ dataset ini telah di *bersihkan* dan *normalisasi* terlebih dahulu oleh pembuat, sehingga mudah digunakan dan ramah bagi pemula. 
- Dataset berupa CSV (Comma-Seperated Values).
- Dataset memiliki 768 sample dengan 9 fitur.
- Dataset memiliki 2 fitur bertipe float64 dan 7 fitur bertipe int.

### Variable - variable pada dataset
- A_id: Menyediakan ID unik untuk setiap baris, dimulai dari 1.
- Pregnancies: Jumlah kehamilan yang pernah dialami.
- Glucose: Konsentrasi glukosa plasma setelah 2 jam dalam tes toleransi glukosa oral.
- BloodPressure: Tekanan darah diastolik (mm Hg).
- SkinThickness: Ketebalan lipatan kulit triceps (mm).
- Insulin: Kadar insulin serum 2 jam (mu U/ml).
- BMI: Indeks massa tubuh (kg/m²).
- DiabetesPedigreeFunction: Fungsi genealogis diabetes.
- Age: Usia (tahun).
- Outcome: Variabel kelas (0 atau 1), di mana 1 menunjukkan diabetes dan 0 tidak.


### EDA - Univariate Analysis
Gambar. Analisis Univariat
![Untitled](https://github.com/user-attachments/assets/c7232e75-10fc-4e04-9b2d-924bcd437e76)

### Correlation Matrix
![Untitled2](https://github.com/user-attachments/assets/f6095bb5-86ed-47cd-a3ed-976175a5629c)


## Data Preparation
Teknik yang digunakan dalam penyiapan data (Data Preparation) yaitu:
- Penanganan Duplicate Values. Pada kasus dataset ini ada beberapa kolom dengan duplicate values dan ditangani dengan melakukan drop untuk menghilangkan redudansi data.
- Mendeteksi outliers. Penanganan dilakukan menggunakan IQR (InterQuartile Range) untuk mendeteksi outliers. IQR dihitung dengan mengurangkan kuartil ketiga (Q3) dari kuartil pertama (Q1) selanjutnya nilai apa pun yang berada di luar batas ini dianggap sebagai outlier.
- Melakukan drop terhadap fitur berdasarkan temuan pada matriks korelasi.
- Split Data atau pembagian dataset menjadi data latih dan data uji menggunakan bantuan train_test_split. Pembagian dataset ini bertujuan agar nantinya dapat digunakan untuk melatih dan mengevaluasi kinerja model. Pada proyek ini, 80% dataset digunakan untuk melatih model, dan 20% sisanya digunakan untuk mengevaluasi model.

## Modeling & Evaluation

Berikut ini ditampilkan output pemodelan yang dikembangkan dengan menggunakan Naive Bayes

```
Loading required package: e1071

Confusion Matrix and Statistics

          Reference
Prediction  0  1
         0 86 21
         1 16 31
                                          
               Accuracy : 0.7597          
                 95% CI : (0.6844, 0.8248)
    No Information Rate : 0.6623          
    P-Value [Acc > NIR] : 0.005717        
                                          
                  Kappa : 0.4499          
                                          
 Mcnemar's Test P-Value : 0.510798        
                                          
            Sensitivity : 0.8431          
            Specificity : 0.5962          
         Pos Pred Value : 0.8037          
         Neg Pred Value : 0.6596          
             Prevalence : 0.6623          
         Detection Rate : 0.5584          
   Detection Prevalence : 0.6948          
      Balanced Accuracy : 0.7196          
                                          
       'Positive' Class : 0
```                             
