---
title: Android ORMLite 框架用法
date: 2016-06-21 14:02:55
tags: [Android,ORMLite]
categories: Android
---
>本文摘自 [鸿神](http://blog.csdn.net/lmj623565791/article/details/39121377)博客,自己偷懒没写,鸿神的写的很详细,他的博客还有 [ORMLite 框架最佳实践](http://blog.csdn.net/lmj623565791/article/details/39122981).

基于鸿神教程运用了ORMLite框架详见我的[Github_QueryCityId](https://github.com/yangxiaoge/queryCityId)

转载请标明出处：http://blog.csdn.net/lmj623565791/article/details/39121377

大家在Android项目中或多或少的都会使用数据库，为了提高我们的开发效率，当然少不了数据库ORM框架了，尤其是某些数据库操作特别频繁的app；本篇博客将详细介绍ORMLite的简易用法。
<!-- more -->
下面开始介绍ORMLite的入门用法~

# 下载 ORMLite Jar
首先去[ORMLite官网下载jar包](http://ormlite.com/releases/)，对于Android为：`ormlite-android-4.48.jar` 和 `ormlite-core-4.48.jar` ；

ps:访问不了的朋友，文章末尾会把jar、源码、doc与本篇博客例子一起打包提供给大家下载。
# 配置Bean类
有了jar,我们直接新建一个项目为：zhy_ormlite，然后把jar拷贝到libs下。

然后新建一个包：com.zhy.zhy_ormlite.bean专门用于存放项目中的Bean，首先新建一个`User.Java`
```
package com.zhy.zhy_ormlite.bean;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "tb_user")
public class User
{
	@DatabaseField(generatedId = true)
	private int id;
	@DatabaseField(columnName = "name")
	private String name;
	@DatabaseField(columnName = "desc")
	private String desc;

	public User()
	{
	}

	public User(String name, String desc)
	{
		this.name = name;
		this.desc = desc;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getDesc()
	{
		return desc;
	}

	public void setDesc(String desc)
	{
		this.desc = desc;
	}

}

```
首先在User类上添加@DatabaseTable(tableName = "tb_user")，标明这是数据库中的一张表，标明为tb_user
然后分别在属性上添加@DatabaseField(columnName = "name") ，columnName的值为该字段在数据中的列名
@DatabaseField(generatedId = true) ，generatedId 表示id为主键且自动生成

# 编写DAO类
原生的数据库操作，需要继承SQLiteOpenHelper，`这里`我们需要`继承OrmLiteSqliteOpenHelper`，看代码：
```
package com.zhy.zhy_ormlite.db;

import java.sql.SQLException;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.j256.ormlite.android.apptools.OrmLiteSqliteOpenHelper;
import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;
import com.zhy.zhy_ormlite.bean.User;

public class DatabaseHelper extends OrmLiteSqliteOpenHelper
{

	private static final String TABLE_NAME = "sqlite-test.db";
	/**
	 * userDao ，每张表对于一个
	 */
	private Dao<User, Integer> userDao;

	private DatabaseHelper(Context context)
	{
		super(context, TABLE_NAME, null, 2);
	}

	@Override
	public void onCreate(SQLiteDatabase database,
			ConnectionSource connectionSource)
	{
		try
		{
			TableUtils.createTable(connectionSource, User.class);
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public void onUpgrade(SQLiteDatabase database,
			ConnectionSource connectionSource, int oldVersion, int newVersion)
	{
		try
		{
			TableUtils.dropTable(connectionSource, User.class, true);
			onCreate(database, connectionSource);
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	private static DatabaseHelper instance;

	/**
	 * 单例获取该Helper
	 * 
	 * @param context
	 * @return
	 */
	public static synchronized DatabaseHelper getHelper(Context context)
	{
		if (instance == null)
		{
			synchronized (DatabaseHelper.class)
			{
				if (instance == null)
					instance = new DatabaseHelper(context);
			}
		}

		return instance;
	}

	/**
	 * 获得userDao
	 * 
	 * @return
	 * @throws SQLException
	 */
	public Dao<User, Integer> getUserDao() throws SQLException
	{
		if (userDao == null)
		{
			userDao = getDao(User.class);
		}
		return userDao;
	}

	/**
	 * 释放资源
	 */
	@Override
	public void close()
	{
		super.close();
		userDao = null;
	}

}
```
这里我们需要继承OrmLiteSqliteOpenHelper，`其实`就是`间接继承`了SQLiteOpenHelper
然后需要实现两个方法：
1、onCreate(SQLiteDatabase database,ConnectionSource connectionSource)
创建表，我们直接使用ormlite提供的TableUtils.createTable(connectionSource, User.class);进行创建~
2、onUpgrade(SQLiteDatabase database, ConnectionSource connectionSource, int oldVersion, int newVersion)
更新表，使用ormlite提供的TableUtils.dropTable(connectionSource, User.class, true);进行删除操作~
删除完成后，别忘了，创建操作：onCreate(database, connectionSource);

然后使用单例公布出一个创建实例的方法，getHelper用于获取我们的help实例；
最后我们可能会有很多表嘛，每个表一般我们都会单独写个Dao用于操作，这里为了简单我并没有抽取出来，直接写在helper中：
比如UserDao的获取：
```
/**
	 * 获得userDao
	 * 
	 * @return
	 * @throws SQLException
	 */
	public Dao<User, Integer> getUserDao() throws SQLException
	{
		if (userDao == null)
		{
			userDao = getDao(User.class);
		}
		return userDao;
	}
```
然后通过获取到的Dao就可以进行User的一些常用的操作了。
# 测试
最后是`测试`，我们直接创建了一个`测试类`进行测试~~~
```
package com.zhy.zhy_ormlite.test;

import java.sql.SQLException;
import java.util.List;

import com.zhy.zhy_ormlite.bean.User;
import com.zhy.zhy_ormlite.db.DatabaseHelper;

import android.test.AndroidTestCase;
import android.util.Log;

public class OrmLiteDbTest extends AndroidTestCase
{

	public void testAddUser()
	{

		User u1 = new User("zhy", "2B青年");
		DatabaseHelper helper = DatabaseHelper.getHelper(getContext());
		try
		{
			helper.getUserDao().create(u1);
			u1 = new User("zhy2", "2B青年");
			helper.getUserDao().create(u1);
			u1 = new User("zhy3", "2B青年");
			helper.getUserDao().create(u1);
			u1 = new User("zhy4", "2B青年");
			helper.getUserDao().create(u1);
			u1 = new User("zhy5", "2B青年");
			helper.getUserDao().create(u1);
			u1 = new User("zhy6", "2B青年");
			helper.getUserDao().create(u1);
			
			testList();
			
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	public void testDeleteUser()
	{
		DatabaseHelper helper = DatabaseHelper.getHelper(getContext());
		try
		{
			helper.getUserDao().deleteById(2);
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	public void testUpdateUser()
	{
		DatabaseHelper helper = DatabaseHelper.getHelper(getContext());
		try
		{
			User u1 = new User("zhy-android", "2B青年");
			u1.setId(3);
			helper.getUserDao().update(u1);
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	public void testList()
	{
		DatabaseHelper helper = DatabaseHelper.getHelper(getContext());
		try
		{
			User u1 = new User("zhy-android", "2B青年");
			u1.setId(2);
			List<User> users = helper.getUserDao().queryForAll();
			Log.e("TAG", users.toString());
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

}
```
`简单测试`了下CURD，使用`AndroidTestCase`记得配置下环境~~~
用起来是不是还是非常方便的，不过还是建议大家例如User的数据库操作，单独抽取出来为UserDao，如下：
```
package com.zhy.zhy_ormlite.db;

import java.sql.SQLException;

import android.content.Context;

import com.zhy.zhy_ormlite.bean.User;

public class UserDao
{
	private Context context;

	public UserDao(Context context)
	{
		this.context = context;
	}

	public void add(User user)
	{
		try
		{
			DatabaseHelper.getHelper(context).getUserDao().create(user);
		} catch (SQLException e)
		{
		}
	}//......

}
```
注：ORMLite还提供了一些基类ORMLiteBaseActivity，ORMLiteBaseService之类的，便于数据库操作的，这里不做考虑，毕竟项目中很大可能自己也需要继承自己的BaseActvity之类的。

上面简单介绍了如何使用ORMLite框架，[Android 快速开发系列 ORMLite 框架的使用](http://blog.csdn.net/lmj623565791/article/details/39122981) 将对其用法进行深入的介绍。

#[源码点击下载](http://download.csdn.net/detail/lmj623565791/7878003)
