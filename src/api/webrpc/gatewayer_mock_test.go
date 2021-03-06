/*
* CODE GENERATED AUTOMATICALLY WITH github.com/ernesto-jimenez/goautomock
* THIS FILE MUST NEVER BE EDITED MANUALLY
 */

package webrpc

import (
	"fmt"

	mock "github.com/stretchr/testify/mock"

	cipher "github.com/dollarydooslab/dollarydoos/src/cipher"
	coin "github.com/dollarydooslab/dollarydoos/src/coin"
	daemon "github.com/dollarydooslab/dollarydoos/src/daemon"
	visor "github.com/dollarydooslab/dollarydoos/src/visor"
	historydb "github.com/dollarydooslab/dollarydoos/src/visor/historydb"
)

// GatewayerMock mock
type GatewayerMock struct {
	mock.Mock
}

func NewGatewayerMock() *GatewayerMock {
	return &GatewayerMock{}
}

// GetAddrUxOuts mocked method
func (m *GatewayerMock) GetAddrUxOuts(p0 []cipher.Address) ([]*historydb.UxOut, error) {

	ret := m.Called(p0)

	var r0 []*historydb.UxOut
	switch res := ret.Get(0).(type) {
	case nil:
	case []*historydb.UxOut:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// GetBlocks mocked method
func (m *GatewayerMock) GetBlocks(p0 uint64, p1 uint64) (*visor.ReadableBlocks, error) {

	ret := m.Called(p0, p1)

	var r0 *visor.ReadableBlocks
	switch res := ret.Get(0).(type) {
	case nil:
	case *visor.ReadableBlocks:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// GetBlocksInDepth mocked method
func (m *GatewayerMock) GetBlocksInDepth(p0 []uint64) (*visor.ReadableBlocks, error) {

	ret := m.Called(p0)

	var r0 *visor.ReadableBlocks
	switch res := ret.Get(0).(type) {
	case nil:
	case *visor.ReadableBlocks:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// GetLastBlocks mocked method
func (m *GatewayerMock) GetLastBlocks(p0 uint64) (*visor.ReadableBlocks, error) {

	ret := m.Called(p0)

	var r0 *visor.ReadableBlocks
	switch res := ret.Get(0).(type) {
	case nil:
	case *visor.ReadableBlocks:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// GetTimeNow mocked method
func (m *GatewayerMock) GetTimeNow() uint64 {

	ret := m.Called()

	var r0 uint64
	switch res := ret.Get(0).(type) {
	case nil:
	case uint64:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0

}

// GetTransaction mocked method
func (m *GatewayerMock) GetTransaction(p0 cipher.SHA256) (*visor.Transaction, error) {

	ret := m.Called(p0)

	var r0 *visor.Transaction
	switch res := ret.Get(0).(type) {
	case nil:
	case *visor.Transaction:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// GetUnspentOutputs mocked method
func (m *GatewayerMock) GetUnspentOutputs(p0 ...daemon.OutputsFilter) (*visor.ReadableOutputSet, error) {

	ret := m.Called(p0)

	var r0 *visor.ReadableOutputSet
	switch res := ret.Get(0).(type) {
	case nil:
	case *visor.ReadableOutputSet:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	var r1 error
	switch res := ret.Get(1).(type) {
	case nil:
	case error:
		r1 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0, r1

}

// InjectBroadcastTransaction mocked method
func (m *GatewayerMock) InjectBroadcastTransaction(p0 coin.Transaction) error {

	ret := m.Called(p0)

	var r0 error
	switch res := ret.Get(0).(type) {
	case nil:
	case error:
		r0 = res
	default:
		panic(fmt.Sprintf("unexpected type: %v", res))
	}

	return r0

}
