# protospace DB

## Model
|Model          |
:---------------:
|user           |
|prototype      |
|prototype_image|
|like           |
|comment        |

## Tables
|Tables          |About                   |
|:--------------:|:----------------------:|
|users           |users data              |
|prototypes      |prototypes data         |
|prototype_images|images data             |
|likes           |likes towards prototypes|
|comments        |comments on prototypes  |

## Associations

user.rb
```
has_many :prototypes
has_many :likes
has_many :comments
```
prototype.rb
```
belongs_to :user
has_many :prototype_images
has_many :likes
has_many :comments
```

prototype_image.rb
```
belongs_to :prototype
enum role: %i(main sub)
```

like.rb
```
belongs_to :user
belongs_to :prototype
```

comment.rb
```
belongs_to :user
belongs_to :prototype
```

## Columns
共通

|カラム名|id     |created_at|updated_at|
|:------:|:-----:|:--------:|:--------:|
|型      |integer|datetime  |datetime  |

### users

|username|email |encrypted_password|profile|work    |group  |avatar|
|:------:|:----:|:----------------:|:-----:|:------:|:-----:|:----:|
|string  |string|varchar           |text   |varchar |varchar|string|

### prototypes
|user\_id  |title    |catch\_copy|concept  |
|:--------:|:-------:|:---------:|:-------:|
|references|varchar  |varchar    |text     |

### prototype_images
|prototype\_id|content  |role   |
|:-----------:|:-------:|:-----:|
|references   |text     |integer|

### likes
|user\_id  |prototype\_id|
|:--------:|:-----------:|
|references|references   |

### comments
|user\_id  |prototype\_id|content|
|:--------:|:-----------:|:-----:|
|references|references   |text   |

