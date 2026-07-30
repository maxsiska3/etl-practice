def max_subarray_sum(nums):
    """ 
    :type nums: List[int] 
    :rtype: int 
    """
    list_total = []
    
    for num in nums:
        for i in range(len(num) - 1):
            total = num[i] + num[i+1]
            list_total.append(total)
        
        return max(list_total)
    
    
print(max_subarray_sum([[1,2,3,4], [1,2,3,4,5], [1,2,3,4,5,6]]))