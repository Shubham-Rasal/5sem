#include<iostream>
#include<bits/stdc++.h>

using namespace std;

// Implement Divide and conquer algorithm to find both the maximum and minumum
// number of elements.
vector<int> max_min(vector<int> &arr , int l , int r) {
    if(l == r) {
        return {arr[l] , arr[l]};
    }

    if(r - l == 1) {
        if(arr[l] > arr[r]) {
            return {arr[l] , arr[r]};
        }
        else {
            return {arr[r] , arr[l]};
        }
    }

    int mid = (l + r) / 2;
    vector<int> left = max_min(arr , l , mid);
    vector<int> right = max_min(arr , mid + 1 , r);

    int max = left[0] > right[0] ? left[0] : right[0];
    int min = left[1] < right[1] ? left[1] : right[1];

    return {max , min};
}


int main() {


    vector<int> arr = {1, 2, 4, 5 , 4534, 3 , 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
    
    vector<int> ans = max_min(arr , 0 , arr.size() - 1);

    cout<<"max : "<<ans[0]<<endl;
    cout<<"min : "<<ans[1]<<endl;

    return 0;
}



















