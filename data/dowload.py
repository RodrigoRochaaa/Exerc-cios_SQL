#%%
import kaggle
import shutil

api = kaggle.KaggleApi()
api.authenticate()
api.dataset_download_file(
    dataset="teocalvo/teomewhy-loyalty-system",
    file_name= "database.db"
)

shutil.move("database.db" , "data/database.db")