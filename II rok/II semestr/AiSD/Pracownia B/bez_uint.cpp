#include <iostream>
#include <utility>
#define maxsize 1000000
using namespace std;


class Heap {
public :
    Heap( int, int);
    void insert(pair< int,  int>);
    pair< int,  int> popMax();
    void move();
    void main();
    void print();

private :
    pair< int,  int> heap[maxsize];
    int size = 0;
    int M;
    int k;
    long long maxPrevious;

    int parent( int);
    int leftChild( int);
    int rightChild( int);

    pair< int,  int> getPair( int);
    pair< int,  int> getMaxPair();
    long long calculateValue(pair< int,  int>);
    long long getValue( int);
    long long getMaxValue();

    void swap( int,  int);

    void removeMax();

    int direction( int,  int);
    void goLeft( int,  int);
    void goUp( int,  int);

    void print_( int);
};







// PUBLICZNE
Heap::Heap( int M, int k) {
    this->M = M;
    this->k = k;
    long long M_ = ( long long)M;
    maxPrevious = M_*M_ + 1;
    insert(make_pair(M_, M_));
}
void Heap::insert(pair< int,  int> p) {
    heap[++size] = p;
    int pI = size, parentI;
    long long pV = calculateValue(p), parentV;

    while(pI > 1) {
        parentI = parent(pI);
        parentV = getValue(parentI);

        if (parentV >= pV)
            return;
        swap(pI, parentI);
        pI = parentI;
    }
}
pair< int,  int> Heap::popMax() {
    pair< int,  int> maxPair = getMaxPair();
    removeMax();
    return maxPair;
}
void Heap::move() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    pair< int,  int> maxPair = popMax();
    long long val = calculateValue(maxPair);
    if (val < maxPrevious) {
        cout << val << '\n';
        maxPrevious = val;
        k--;
    }

    int i = maxPair.first, j = maxPair.second;
    goLeft(i,j);
    goUp(i,j);
}
void Heap::main() {
    while (k) {
        move();
    }
}
void Heap::print(){
    cout << "size = " << size << '\n';
    print_(1);
    cout << '\n';
}



// PRYWATNE
int Heap::parent( int i) {
    return i/2;
}
int Heap::leftChild( int i) {
    return 2*i;
}
int Heap::rightChild( int i) {
    return 2*i + 1;
}


pair< int,  int> Heap::getPair( int i) {
    return heap[i];
}
pair< int,  int> Heap::getMaxPair() {
    return getPair(1);
}
long long Heap::calculateValue(pair< int,  int> p) {
    long long i = p.first, j = p.second;
    return i*j;
}
long long Heap::getValue( int i) {
    pair< int,  int> p = getPair(i);
    long long value = calculateValue(p);
    return value;
}
long long Heap::getMaxValue() {
    return getValue(1);
}

void Heap::swap( int i,  int j) {
    pair< int,  int> iPair, jPair;
    iPair = getPair(i);
    jPair = getPair(j);
    heap[i] = jPair;
    heap[j] = iPair;
}


void Heap::removeMax() {
    swap(1, size--);
    int i = 1, leftChildI, rightChildI;
    long long value, leftChildValue, rightChildValue;

    while (true) {
        leftChildI = leftChild(i);
        rightChildI = rightChild(i);

        // nie ma syna
        if (leftChildI > size)
            return;
        // ma tylko lewego syna
        else if (leftChildI == size) {
            if (getValue(leftChildI) > getValue(i))
                swap(i, leftChildI);
            return;
        }

        // ma obu synów
        value = getValue(i);
        leftChildValue = getValue(leftChildI);
        rightChildValue = getValue(rightChildI);

        if (rightChildValue >= leftChildValue) {
            if (value >= rightChildValue)
                return;
            swap(i, rightChildI);
            i = rightChildI;
        } else if (value >= leftChildValue) {
            return;
        } else {
            swap(i, leftChildI);
            i = leftChildI;
        }
    }
}


int Heap::direction( int i,  int j) {
    // 0 -> nie należy iść w to pole
    // 1 -> należy w to pole wejść od prawej
    // 2 -> należy w to pole wejść od dołu

    // poza granicami
    if (i < j || j == 0)
        return 0;
    // na skosie
    if (i == j)
        return 1;
    // na najbardziej prawej kolumnie
    if (i == M)
        return 2;

    long long lowParentI = i, lowParentJ = j+1, lowParentValue;
    lowParentValue = lowParentI*lowParentJ;
    long long rightParentI = i+1, rightParentJ = j, rightParentValue;
    rightParentValue = rightParentI*rightParentJ;
    // jeśli low > right to znaczy, że od dołu będzie/było szybciej w kolejce wyrzucone
    return (lowParentValue > rightParentValue) + 1;
}
void Heap::goLeft( int i,  int j) {
    int dir = direction(i-1, j);
    if (dir != 1) 
        return;
    pair< int,  int> p = make_pair(i-1, j);
    insert(p);
}
void Heap::goUp( int i,  int j) {
    int dir = direction(i, j-1);
    if (dir != 2)
        return;
    pair< int,  int> p = make_pair(i, j-1);
    insert(p);
}

void Heap::print_( int i = 1) {
    if (i > size)
        return;
    pair< int,  int> p = getPair(i);
    int xi = p.first, yi = p.second;
    cout << "i = " << i << " -> " << getValue(i) << " " << xi << " " << yi << '\n';
    print_(leftChild(i));
    print_(rightChild(i));
}

void program() {
    int M, k;
    cin >> M >> k;
    Heap A(M, k);
    A.main();
}

void probne(){
    int M, k;
    M = 10;
    k = 5;
    Heap A(M, k);
    A.main();
}

int main()
{
    program();
}



