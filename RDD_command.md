#  RDD Commands

## RDD

### RDD Transformations
- ##### Transformations are operations on RDDs that return a new RDD

- ##### All transformations are lazy and only computed when an action requires a result



#### map()

return a new RDD by applying a function to each element of this RDD.

```python
sc.parallelize(["b","a","c"]).map(lambda x:(x,1)).collect()
> [('b', 1), ('a', 1), ('c', 1)]

sc.parallelize([2,3,4]).map(lambda x:[(x,x),(x,x)]).collect()
> [[(2, 2), (2, 2)], [(3, 3), (3, 3)], [(4, 4), (4, 4)]]

sc.parallelize([2,3,4]).map(lambda x:range(1,x)).collect()
> [range(1, 2), range(1, 3), range(1, 4)]
```



#### flatMap()

return a new RDD by first applying a function to all elements of this RDD, and then flattening the results.

```python
sc.parallelize([2,3,4]).flatMap(lambda x:range(1,x)).collect()
> [1, 1, 2, 1, 2, 3]

sc.parallelize([2,3,4]).flatMap(lambda x:[(x,x),(x,x)]).collect()
> [(2, 2), (2, 2), (3, 3), (3, 3), (4, 4), (4, 4)]

```



#### fliter()  like "if"

return a new RDD containing only the elements that satisfy a predicate.

```python
sc.parallelize([1,2,2,3,4,5,6]).filter(lambda x:x%2==0).collect()
> [2, 2, 4, 6]
```



#### distinct()

return a new RDD containing the distinct elements in this RDD.

```python
sc.parallelize([1,2,2,3,4,5,6]).distinct().collect()
> [4, 1, 5, 2, 6, 3]
```



#### union()

return an RDD containing data from both sources. Unlike the mathmatical union, duplicates are not removed.





### RDD Actions

- ##### Actions are operations that return a final value to the driver program or write data to an external storage system. 

- #### Actions force the evaluation of the transformations required for the RDD.



#### collect()

return a list that contains all of the elements in this RDD.

```python
m = sc.parallelize([(1,2),(3,4)]).collect()
> [(1, 2), (3, 4)]
m[0]
> (1, 2)
```



#### collectAsMap()

return the key-value pairs in this RDD to the master as a dictionary.

```python
m = sc.parallelize([(1,2),(3,4)]).collect()
> {1: 2, 3: 4}
m[1]
> 2
m[3]
> 4
```



#### take(), first()

take(): take the first num elements of the RDD.

first(): return the first element in this RDD.



#### count(), countByValue()

count(): return the number of elements in this RDD.

countByValue(): return the count of each unique value in this RDD as a dictionary of (value,count) pairs.

```python
sc.parallelize([2,3,4]).count()
> 3
sc.parallelize([1,3,4,5,3,1,2,1,2,3,4]).countByValue()
> defaultdict(int, {1: 3, 2: 2, 3: 3, 4: 2, 5: 1})
sc.parallelize([1,3,4,5,3,1,2,1,2,3,4]).countByValue().items()
> dict_items([(1, 3), (2, 2), (3, 3), (4, 2), (5, 1)])
```



#### reduct(), aggregation()

reduct(): redoces the elements of this RDD using the specified commutative and associative binary operator. Currently reduces partitions locally.

aggregation(): Aggregate the elements of each partition, and then the results for all the partitions, using a given combine functions and a neutral "zero value". 

```python
sc.parallelize([1,2,3,4,5]).reduce(lambda x,y : x + y)
> 15

numbers = sc.parallelize([1,2,3,4,5,8])
result = numbers.aggregate(0, lambda acc,v:acc+u, lambda acc1,acc2:acc1+acc2)

numbers = sc.parallelize([1,2,3,4,5,8])
temp = numbers.aggregate( (0,0), lambda acc,v:(acc[0]+v, acc[1]+1), lambda acc1,acc2:(acc1[0]+acc2[0],acc1[1]+acc2[1]) )
```



#### foreach()
Applies a function to all elements of this RDD.

```python
sc.parallelize([1,2,3,4,5]).foreach(lambda x:print(x))
```





### Key-Value RDD Actions
- #### Working on data in key-value pairs



#### keys()

Return an RDD with the keys of each tuple.

```
sc.parallelize([(1,2),(3,4)]).keys().collect()
```

